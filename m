Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWIYTPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWIYTPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIYTPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:15:03 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:40017 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751501AbWIYTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:15:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6Z25gTO+gRek3J9kDqH80E0JijXHR9NanOGwy6u2DIZ3j7SjD5Vd7VL/8ZuQNA93RCG3k/iYeNR2SG5zdAEQtjwzKZ0+0nR8jFFde7lbic3LjvJ8eByHSl13EBrGTw0KRlQoI39HJOlLlrQK0ET30G3jNhftm0JyPz/c1pmP37g=  ;
Message-ID: <20060925191459.55364.qmail@web31801.mail.mud.yahoo.com>
Date: Mon, 25 Sep 2006 12:14:59 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
To: James Bottomley <James.Bottomley@SteelEye.com>,
       "Hammer, Jack" <Jack_Hammer@adaptec.com>,
       Al Viro <viro@ftp.linux.org.uk>
Cc: Luben Tuikov <ltuikov@yahoo.com>, dougg@torque.net,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1159206202.3463.62.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Mon, 2006-09-25 at 18:39 +0100, Al Viro wrote:
> > Far more interesting question: where does the hardware expect to see
> > the
> > upper 16 bits of that 32bit value?  Which one it is -
> > LmSEQ_INTEN_SAVE(lseq)
> > ori LmSEQ_INTEN_SAVE(lseq) + 2?
> 
> I don't honestly know.  The change was made as part of a slew of changes
> by Robert Tarte at Adaptec to make the driver run on Big Endian
> platforms.  I've copied Jack Hammer who's now looking after it in the
> hope that he can enlighten us.

Al,

I can see that you addressed your message to me, but Bottomley has
stepped in to answer.  I can also see that Bottomley is looking
for an answer from Jack.  To save an off the list correspondence,

I'll go ahead and answer your question addressed to me.

LSEQ_INTEN_SAVE is a 32 bit Little-Endian storage, thus
your original, first email on this subject is correct, and your
supposition that if the storage is 32 bit LE, then my version
is correct, is in itself correct.

No such "changes" (in the HW page writing area) are necessary in order
to make the code run in BE platforms.  My version of my code
(NOT Bottomley's version of my code) has been extensively tested on
BE (PowerPC) platforms, and is working properly.

The version as seen in my code:
	asd_write_reg_dword(asd_ha, LmSEQ_INTEN_SAVE(lseq),
			    (u32) LmM0INTEN_MASK);
is the correct way.

Good luck!
    Luben
P.S. Git tells me that I needed to change two lines only,
in order to make the code run on BE platforms, the git commit
dates Wednesday Sept 28, 2005.  That commit is present on
the GIT repo, then present on http://linux.adaptec.com/sas/.

