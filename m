Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSDIOFk>; Tue, 9 Apr 2002 10:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSDIOFj>; Tue, 9 Apr 2002 10:05:39 -0400
Received: from www.m3.polymtl.ca ([132.207.4.60]:48145 "HELO m3.polymtl.ca")
	by vger.kernel.org with SMTP id <S293076AbSDIOFi>;
	Tue, 9 Apr 2002 10:05:38 -0400
To: linux-kernel@vger.kernel.org, Martin@m3.polymtl.ca,
        J.Bligh@m3.polymtl.ca (Martin.Bligh@us.ibm.com)
Cc: Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>, karym@opersys.com, lmcmpou@lmc.ericsson.se,
        lmcleve@lmc.ericsson.se
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <87960000.1018307908@flay>
From: Michel Dagenais <michel.dagenais@polymtl.ca>
Date: 09 Apr 2002 10:21:21 -0400
Message-ID: <m2it71uf4u.fsf@m3.polymtl.ca>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> People want to be able to get better debug information, with more detail
> than is currently possible with printk, hence the Event logging project.

I would like to emphasize that point; logging and tracing is of prime 
importance in several areas:

- Telecom and Security. Logging and auditing is a requirement in Telecom 
  applications. It is for instance one of the important features of the 
  Distributed Security Infrastructure proposed by Ericsson Research and to 
  be presented in a couple of months at the Ottawa Linux Symposium.
  The OSDL "Carrier Grade Linux" is certainly no different.

- Real time systems. A low overhead trace is often the only way to debug
  these systems. Lineo, Monte-Vista, and FSM labs all have logging solutions,
  most based on the Linux Trace Toolkit (www.opersys.com/LTT). It would be 
  relatively easy to merge the best features of these two systems, present 
  on the 2.5 status list, (high volume low overhead of LTT and event 
  templates and filtering of EVLOG).

- Kernel/device drivers debugging.

- Detailed performance analysis. Using the Linux Trace Toolkit, it is possible
  to extract very detailed information like the time spent by a process
  executing, executing on behalf of client x, waiting for file y 
  (read/page fault), waiting for process z... 

The current printk simply does not cut it for these applications. There are
over 80000 printk statements in the kernel, using many different conventions.
A few tens of driver specific tracing facilities (SCSI, ftape, wireless...)
were implemented each with its own mechanism to compile/not the debugging
statements, trigger massive debugging output at runtime...

The EVLOG proposition strikes me as a good balance between solid features,
simplicity, and ease of integration/transition with the current printk.

Here are some of the advantages of more structured logging:

- More consistent activation mechanisms for logging points
  troughout the kernel at configuration/compilation time and at runtime.

- Structured data events for which it is easier to apply filtering, querying,
  analysis and detection tools.

- More compact format, when desired, where data and text descriptions are 
  separated. This facilitates high volume applications (lower logging 
  overhead, smaller files) and also enables customization/i18n of the static 
  text descriptions.

- In its current configuration, klogd rapidly looses events under high volumes.
  The Linux Trace Toolkit with its zero-copy, kernel-daemon shared memory,
  does much better under heavy debugging/tracing output.
