Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291110AbSBSKry>; Tue, 19 Feb 2002 05:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291117AbSBSKrp>; Tue, 19 Feb 2002 05:47:45 -0500
Received: from ns.suse.de ([213.95.15.193]:30981 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291110AbSBSKrd>;
	Tue, 19 Feb 2002 05:47:33 -0500
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.44.0202191000030.26361-100000@holly.crl.go.jp>
X-Yow: Can I have an IMPULSE ITEM instead?
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 19 Feb 2002 11:47:30 +0100
In-Reply-To: <Pine.LNX.4.44.0202191000030.26361-100000@holly.crl.go.jp> (Tom
 Holroyd's message of "Tue, 19 Feb 2002 10:47:34 +0900 (JST)")
Message-ID: <jeheod929p.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Holroyd <tomh@po.crl.go.jp> writes:

|> So what is the 4th value in /proc/stat (procps calls it "other", while
|> the first 3 are "user", "nice", and "sys")?  According to
|> linux/fs/proc/proc_misc.c, it is:
|> 
|> 	jif * smp_num_cpus - (user + nice + system)
|> 
|> formatted with a %lu (the others are just %u).  smp_num_cpus is 1.
|> Things are declared this way:
|> 
|>         unsigned long jif = jiffies;
|>         unsigned int sum = 0, user = 0, nice = 0, system = 0;
|> 
|> So, the problem is that user + nice + system overflows (I'm compiling
|> with gcc 3.0, BTW).
|> 
|> Thanks for the clue; now, how to fix it?

Changing the line to this:

 	jif * smp_num_cpus - user - nice - system

should avoid the overflow.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
