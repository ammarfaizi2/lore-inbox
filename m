Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbQKGNd3>; Tue, 7 Nov 2000 08:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbQKGNdT>; Tue, 7 Nov 2000 08:33:19 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:42258 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130679AbQKGNdJ>;
	Tue, 7 Nov 2000 08:33:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 09:45:42 -0300."
             <200011071245.eA7Cjhw20987@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 00:33:03 +1100
Message-ID: <13692.973603983@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000 09:45:42 -0300, 
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>Keith Owens <kaos@ocs.com.au> said:
>> I have not decided where to save the persistent module parameters.  It
>> could be under /lib/modules/<version>/persist or it could be under
>> /var/log or /var/run.  I am tending towards /var/run/module_persist, in
>> any case it will be a modules.conf parameter.
>
>/var/lib/persist/<version>/<wherever-the-module-is-in-/lib/modules/<version>/>
>
>or some such. It has to match the kernel version somewhere (in case module
>interfaces change),

But then you get the problem that upgrading from one kernel release to
the next loses the persistent data; either option has potential
problems.  I am tending towards no version number and have a flag on
insmod that says "the following parameters may not exist in the module,
be silent about any unknown symbols", the flag is automatically set by
modprobe for persistent parameters.

Going forward is not a problem, going backwards silently ignores
unknown parameters.

>and it also should mirror the tree under
>/lib/modules/<version> if for no other reason that there might show up
>several modules named <foo>.

It makes no sense to allow duplicate module names in the same kernel
tree.  "modprobe foo" - which one gets loaded?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
