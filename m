Return-Path: <linux-kernel-owner+w=401wt.eu-S932992AbWLSXgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbWLSXgK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933004AbWLSXgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:36:10 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:23954 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932992AbWLSXgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:36:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mESmr6UVV/8vqxFN6w1hJs5Hpd3pOmD+9kI8mEzGytgxE1SwISvCFwtcRQ0OCyQLZVKPCFRHUlUG3u7RuP21umQqd8JufWxjpK4vQUKjXh+TP4up9BaDlEDenQtRvX4Vqk+ytz1Z3ecZW9OmqKqlTtCJrpBKfcXXP93BLVbI7eY=;
X-YMail-OSG: WrCYeGYVM1kmZDLIRbpGzFwZtG4HUIUL7mRMwJWo8MoxUIVMHLAiOcU7oCpxG0cqI9oqyeWpotbjG5H1ODH_odOGrqNqlDFZ.gc3NQ776wp5j3A8BsG594hjOK2FQFy0TGpUndHs9lw-
Date: Tue, 19 Dec 2006 15:29:26 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: 2.6.20-rc1-mm1
To: Damien Wyart <damien.wyart@free.fr>,
       Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com
In-Reply-To: <20061218183526.GA14297@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <974516.94834.qm@web31801.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Damien Wyart <damien.wyart@free.fr> wrote:
> > > > The reiser4 failure is unexpected. Could you please see if you can
> > > > capture a trace, let the people at reiserfs-dev@namesys.com know?
> 
> > > Ok, I've handwritten the messages, here they are :
> 
> > > reiser4 panicked cowardly : reiser4[umount(2451)] : commit_current_atom 
> > > (fs/reiser4/txmngr.c:1087) (zam-597)
> > > write log failed (-5)
> 
> > > [ got 2 copies of them because I have 2 reiser4 fs)
> 
> > > I got them mainly when I try to reboot or halt the machine, and the
> > > process doesn't finish, the computer gets stuck after the reiser4
> > > messages. This is only with 2.6.20-mm1, not 2.6.19-rc6-mm2.
> 
> * Laurent Riffard <laurent.riffard@free.fr> [2006-12-18 09:03]:
> > fix-sense-key-medium-error-processing-and-retry.patch seems to be the
> > culprit.
> 
> > Reverting it fix those reiser4 panics for me. Damien, could you confirm 
> > please ?
> 
> Yes, this fixes it too on my side. Thanks for this tracking !

I had a bug in my dev tree which got picked up by the patch
when I diffed against master:

-           scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
+           scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
                return;

As james explained, the other chunk of the patch is still good.

    Luben

