Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUBPONV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUBPONV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:13:21 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:59485 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265869AbUBPONM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:13:12 -0500
Date: Mon, 16 Feb 2004 08:13:09 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Harald Dunkel <harald.dunkel@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
In-Reply-To: <40306F65.8060702@t-online.de>
Message-ID: <Pine.LNX.4.58.0402160808100.14001@ryanr.aptchi.homelinux.org>
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it>
 <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu>
 <40306F65.8060702@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Harald Dunkel wrote:

> Ryan Reich wrote:
> > Harald Dunkel wrote:
> >
> >>
> >> I am interested in the module file names. 'cat /proc/modules'
> >> should return the correct module names, but for some modules
> >> (like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.
> >
> >
> > According to the modprobe man page, the two symbols are interchangeable.
> >
> I know. But this requires some very ugly workarounds outside
> of module-init-tools. For example, if you want to check
> whether a module $module_name has already been loaded, you
> cannot use
>
>      grep -q "^${module_name} " /proc/modules
>
> Instead you have to use a workaround like
>
>      x="`echo $module_name | sed -e 's/-/_/g'`"
>      cat /proc/modules | sed -e 's/-/_/g' | grep -q "^${x} "
>
> This is inefficient and error-prone.
>
> Maybe somebody has another idea for the workaround,
> but I like the first version.

Well, you can shorten it by using 'tr':

cat /proc/modules | tr _ - | grep -q "^${module_name} "

/proc/modules uses the '_' and I suppose your problem is that your module name
list uses the '-', so this solves both at once.

-- 
Ryan Reich
ryanr@uchicago.edu
