Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292836AbSCSVQc>; Tue, 19 Mar 2002 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCSVQQ>; Tue, 19 Mar 2002 16:16:16 -0500
Received: from [195.39.17.254] ([195.39.17.254]:61058 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292837AbSCSVPZ>;
	Tue, 19 Mar 2002 16:15:25 -0500
Date: Tue, 19 Mar 2002 15:29:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, dan@debian.org, tachino@jp.fujitsu.com,
        jefreyr@pacbell.net, mgross@unix-os.sc.intel.com,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020319152959.C55@toy.ucw.cz>
In-Reply-To: <20020315170726.A3405@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Other threads are prevented from executing while core dump is in 
>   progress to improve the accuracy of the dumps. This is done without 
>   changing the state of the task. We set cpus_allowed in task struct 
>   to be 0 to stop a task from being scheduled and reset it to -1 for
>   resume execution. This has the advantage to not depending on user
>   space at all for correct functioning. IMO sending SIGSTOP to stop 
>   other threads does not work if the process is being run under a 
>   debugger. The only possible issue with using cpus_allowed is that 

In swsusp patch, I had exactly the same problem. I created refrigerator(),
and halfway send a signal.... 

> +/*
> + * Suspend execution of other threads belonging to the same multithreaded process 
> + * of current, ASAP.
> + *
> + * Sets the current->cpu_mask to the current cpu to avoid cpu migration durring the dump.
> + * This cpu will also be the only cpu the other threads will be allowed to run after 
> + * coredump is completed. This seems to be needed to fix some SMP races.  This still
> + * needs some more thought though this solution works.

What about

app has 5 threads. 1st dumps core, and starts setting cpus_allowed mask to
thread 2. Meanwhile 3nd thread resets the mask back.

								Pavel?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

