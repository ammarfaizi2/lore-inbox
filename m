Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUHPDFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUHPDFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUHPDFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:05:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28034 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267374AbUHPDFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:05:50 -0400
Date: Mon, 16 Aug 2004 05:06:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816030601.GA10616@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu> <20040816025846.GA10240@elte.hu> <1092625400.867.126.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1092625400.867.126.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Sun, 2004-08-15 at 22:58, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > i've attached mlock-test2.cc that should test this theory. The code
> > breaks up the mlock-ed region into 8 equal pieces and does mlock() on
> > them separately. It's basically a lock-break done in user-space. Does
> > this change the nature of xruns?
> 
> -ENOATTACHMENT

-ESTILLTOOEARLY. attached now.

	Ingo

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mlock-test2.cc"

// here is the code i used to test the mlockall caused xruns
#include <sys/mman.h>
#include <iostream>
#include <sstream>
#include <unistd.h>

#define INTERVALS 8

int main (int argc, char *argv[]) {
        if (argc < 2) {
                std::cout << "how many kbytes you want allocated and mlockall'ed?" << std::endl;
        }

        std::stringstream stream(argv[1]);
        int kbytes, error = 0, i, chunk;

        stream >> kbytes;
        char *mem = new char[kbytes*1024];
        std::cout << "filling with 0's" << std::endl;
        for (int i = 0; i < kbytes*1024; ++i) {
                mem[i] = 0;
        }

        std::cout << "ok, you want " << kbytes << "kb of memory mlocked.  going for it.." << std::endl;
	chunk = kbytes*1024/INTERVALS;
	for (i = 0; i < INTERVALS; i++)
        	error |= mlock(mem + i*chunk, chunk);
        if (error != 0) { std::cout << "mlock error" << std::endl; }
        else { std::cout << "mlock successfull" << std::endl;}
}


--zhXaljGHf11kAtnf--
