Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133117AbRDLMoO>; Thu, 12 Apr 2001 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRDLMny>; Thu, 12 Apr 2001 08:43:54 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:23820 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S133117AbRDLMnw>; Thu, 12 Apr 2001 08:43:52 -0400
Message-Id: <m14ngRr-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: SCSI Tape Corruption - update
In-Reply-To: <20010412084318.LESP2878.fep02-svc.tin.it@fep41-svc.tin.it>
 "from lomarcan@tin.it at Apr 12, 2001 10:43:18 am"
To: lomarcan@tin.it
Date: Thu, 12 Apr 2001 07:43:43 -0500 (CDT)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lomarcan@tin.it wrote:
> It seems that the tape is written incorrectly. I wrote some large file
> (300MB)
> and read it back four time. The read copies are all the same. They differ
> from the original only in 32 consecutive bytes (the replaced values SEEM
> random). Of course, 32 bytes in 300MB tar.gz files are TOO MUCH to be 
> accepted :)

Several years ago I ran into a problem with similar symptoms on an old
Adaptec AHA-154X controller.  Files (and most certainly "file systems"
if I had persisted) on my hard disk were getting corrupted in random
places with constant length strings of garbage.  This turned out to be
an inappropriate setting for the AHA1542_SCATTER constant: it *was* 16,
and setting it to 8 fixed my problem.  I'd look for a similar "#define"
in the header file for your SCSI device driver and try cutting the value
by half.  Why "half"?  No justification other than it worked for me, and
it's a power-of-two kind of thing that hardware seems to like :-).

--Bob
