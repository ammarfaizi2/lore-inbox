Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRIDRFs>; Tue, 4 Sep 2001 13:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272015AbRIDRFj>; Tue, 4 Sep 2001 13:05:39 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:49604 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271697AbRIDRF1>; Tue, 4 Sep 2001 13:05:27 -0400
Importance: Normal
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc
 architecture
To: John Alvord <jalvo@mbay.net>
Cc: Jeff Mahoney <jeffm@suse.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFF77409CC.FF70C78C-ONC1256ABD.005CEB95@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Tue, 4 Sep 2001 19:04:37 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 04/09/2001 19:04:42
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:

>> It is only *atomic* accesses (those implemented using the S/390
>> compare-and-swap instruction) that need to be word aligned; this
includes
>> the atomic bit operations that reiserfs appears to be using.
>
>Aren't their some other "must align" instructions like CVB? Or have they
>all been relaxed...

CVB doesn't have any alignment requirement (I'm not sure it ever had one).
Execpt for the 'atomic' operations (CS, CSG, CDS, CDSG, LPQ, STPQ, PLO)
I know only of two general-purpose instructions with operand alignment
requirement, and that's LAM and STAM.  As access registers are not
normally used in Linux this shouldn't be a problem.

There *is* a whole bunch of privileged system instructions that have
various aligment requirements; but here I'd say it's fair to require the
user to provide correct aligment in these special cases.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

