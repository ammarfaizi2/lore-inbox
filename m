Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTDLMCU (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTDLMCU (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 08:02:20 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:62707 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263251AbTDLMCT (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 08:02:19 -0400
Date: Sat, 12 Apr 2003 14:24:22 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org, thockin@isunix.it.ilstu.edu
Subject: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <20030412122422.GB9125@wind.cocodriloo.com>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1050146434.3e97f68300fff@netmail.pipex.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 12:20:35PM +0100, Shaheed R. Haque wrote:
> 
> Hi,
> 
> Looking through the archive etc., I cannot see any references to pset 
> functionality more recently than
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/9904.1/0521.html
> 
> announcing an updated patch in April 1999. Are there any plans out there to 
> include this, or similar functionality in 2.5/2.6? I'm particularly interested 
> in getting exclusive access to a CPU (plus or minus HT support, for now anyway).

Shaheed, I think that task->cpu_allowed covers your need, since it
describes a mask of cpu�'s allowed to run the task. CPU migration, for
example, is implemented in current scheduler by saving the
current cpu_allowed, forcing it to contain only the destination CPU and
then restoring it.

I think it's carried over by fork(), but have been unable to find
it on the sources.

HT is accounted as a NUMA SMP system with strong memory affinity
for his 2 cores, so that when running 2 HT processors (2+2 cores),
the tasks are kept preferably on the same HT processor and just bounce
cores, since they share the same cache (don't know exactly L1, L2 or
both, tough).

Greets, Antonio.
