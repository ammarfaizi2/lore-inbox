Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129889AbQKGWwz>; Tue, 7 Nov 2000 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbQKGWwo>; Tue, 7 Nov 2000 17:52:44 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30729 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129598AbQKGWwc>;
	Tue, 7 Nov 2000 17:52:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 16:30:22 MDT."
             <200011072230.QAA304551@tomcat.admin.navo.hpc.mil> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 09:52:20 +1100
Message-ID: <17582.973637540@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 16:30:22 -0600 (CST), 
Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote:
> From: Keith Owens <kaos@ocs.com.au> 
>> No need for a separate size field.  Note that MODULE_PARM is built at
>> compile time so all persistent data must have a fixed compile time
>> size.
>
>I'll buy that - but it does mean that if there are 300 items then it
>will get LONG... but then, that can be handled. I was thinking of the
>"parameter" to possibly being a full data structure that could be updated
>in an atomic manner, with a minimum of overhead (no number conversions
>in the kernel).

Irrelevant.  Remember that persistent module data is only set when the
module is loaded and retrieved when it removed.  Atomicity and speed
are not an issue at those points.

>> Pure binary immediately runs into kernel version skew problems.
>
>The identification of data version should be left up to the userspace
>utility that retrieves the data.

The userspace utilities are insmod and rmmod.  No, I am not going to
put version numbers into the saved data.

>For some things, yes. I was thinking of things like automatically changing
>the scheduling priorities for batch+interactive use. Also things like
>fair-share scheduler parameters, resident set size/swap resource control,
>(other large system capabilities, I admit).

All of which are system level tuning parameters that vary based on time
and/or load.  My MVS sysprog hat says that there is no point in saving
these parameters across a reboot.  Instead you have global targets
which rarely change and let the system tue to meet the targets - like
MVS Work Load Manager.  These settings are nothing to do with modules.

>I know it wasn't considered, but batch schedulers may have their parameters
>changed hourly. My site currently works with one that has parameters changed
>to reflect available resources for future scheduling cycles that use updated
>job priorities to determine how the system should respond.

And what is the point of saving those parameters?  Firstly they will
not be implemented via modules.  Secondly the values just before
shutdown and at startup will not be useful for the peak hour load, nor
for the overnight backup window.  Again, set targets and let the system
auto tune.  The only thing you save are the overall targets, those are
already in text files with their own specific format.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
