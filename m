Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVCVDFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVCVDFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCVCp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:45:27 -0500
Received: from smtp06.auna.com ([62.81.186.16]:45298 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262341AbVCVCM4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:12:56 -0500
Date: Tue, 22 Mar 2005 02:12:52 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Distinguish real vs. virtual CPUs?
To: Dan Maas <dmaas@maasdigital.com>
Cc: linux-kernel@vger.kernel.org
References: <20050321202726.A7630@morpheus>
In-Reply-To: <20050321202726.A7630@morpheus> (from dmaas@maasdigital.com on
	Tue Mar 22 02:27:26 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111457572l.9192l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.22, Dan Maas wrote:
> Is there a canonical way for user-space software to determine how many
> real CPUs are present in a system (as opposed to HyperThreaded or
> otherwise virtual CPUs)?
> 

This is 2xXeonHT, is, 4 cpus on 2 packages:

cat /proc/cpuinfo:

processor	: 0
...
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1

processor	: 1
...
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1

processor	: 2
...
physical id	: 3
siblings	: 2
core id		: 3
cpu cores	: 1

processor	: 3
...
physical id	: 3
siblings	: 2
core id		: 3
cpu cores	: 1

So something like:

cat /proc/cpuinfo | grep 'core id' | uniq | wc -l

would give you the number of packages or 'real cpus'. Then you have to
choose which ones are unrelated. Usually evens are siblings of odds, but
I won't trust on it...

> We have an application that for performance reasons wants to run one
> process per CPU. However, on a HyperThreaded system /proc/cpuinfo
> lists two CPUs, and running two processes in this case is the wrong
> thing to do. (Hyperthreading ends up degrading our performance,
> perhaps due to cache or bus contention).
> 

I always hear people about HT 'degrading' performance. Obviously you don't
get a 200%, but it is always better than 100%. With my simulation code,
in which I did not anything special for HT (it uses my 4 cpus as 'real' ones),
I usually get a 125-130% gain. So the theoretical performance loos true.
Your application behaviour has to be really nasty to run slower with 2 threads
on an HT-P4 that with one thread.

Hope this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam6 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #1


