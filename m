Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUFCG7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUFCG7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUFCG7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:59:34 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:17781 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261418AbUFCG6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:58:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
Date: Thu, 3 Jun 2004 01:58:42 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
References: <20040602190927.79289.qmail@web81306.mail.yahoo.com> <200406030116.49431.dtor_core@ameritech.net> <xb7hdtt3zs4.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7hdtt3zs4.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030158.42703.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 01:45 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> So we have several options - if we adopt procfs based
>     Dmitry> solution now we will have to maintain it for very long
>     Dmitry> time, along with competing sysfs implementation. Dropping
>     Dmitry> one kernel parameter which will never be widely used is
>     Dmitry> much easier, IMO.
> 
>     >>  It's not just the matter of dropping one kernel parameter.
>     >> The procfs support, _already implemented_, allows one to
>     >> fine-tune the binding between serio ports and devices, which is
>     >> a new and useful feature that your kernel parameter doesn't
>     >> provide.
> 
>     Dmitry> What I was trying to say is serio and input system will
>     Dmitry> have sysfs support, 
> 
> Then, why are you saying "dropping one kernel parameter"?

I am referring to possibly dropping i0842.raw once sysfs is implemeted
as then user will be able to rebind another driver to a port, like
your procfs patch does. 

> 
> 
> 
>     >>  Can you unbind the keyboard port?  Can you bind/unbind any of
>     >> the AUX ports *dynamically* without reloading the i8042 module?
>     >> These
> 
>     Dmitry> No, and I was not trying to. It is just a stop-gap measure
>     Dmitry> to help end users to get their PS/2 devices working until
>     Dmitry> we have proper infrastructure in place.
> 
> I think  direct access to PS/2  devices must stay there  for the whole
> 2.6.x.  It's  unreasonable to assume  that all existing  _and working_
> drivers will be kernelized.
> 
> 
> 
>     >>  sysfs looks good for simple parameters: integers, strings.
>     >> For anything more complicated (sets, graphs), I don't see it
>     >> fit (yet).  Unfortunately, the serio port<-->device relation is
>     >> already a graph (1 to n).
>     >> 
>     >> I'd like to see how you implement the device<-->handler binding
>     >> in input.c using sysfs.
> 
>     Dmitry> Sysfs provides all the same features as procfs (I mean you
>     Dmitry> write read/write methods and have them do whatever you
>     Dmitry> please) but it also has benefits of your stuff integrating
>     Dmitry> with the rest of devices into a hierarchy.
> 
> It's  different.  Procfs is  more versatile.   I can  stuff in  my own
> struct file_operations to do more than just read() and write().  I can
> even stuff in my own struct inode_operations if I want more.
> 
> Another problem with sysfs is  the "social" discipline as mentioned in
> Documentation/filesystems/sysfs.txt:
> 
>         Attributes should be ASCII text files, preferably with only
>         one value per file. It is noted that it may not be efficient
>         to contain only value per file, so it is socially acceptable
>         to express an array of values of the same type.
> 
>         Mixing types, expressing multiple lines of data, and doing
>         fancy formatting of data is heavily frowned upon. Doing these
>         things may get you publically humiliated and your code
>         rewritten without notice.
> 
> It is  common in procfs  to format the  output nicely, and  to display
> screenfuls  of information.   This is  to  be frowned  upon in  sysfs.
> Currently  implementations  of sysfs  interface  do  follow this  rule
> nicely.
> 
> Unfortunately, the  connection between devices and  drivers (either in
> the serio.c interface or in the  input.c interface) is a graph.  It is
> more complicated than an array.  Yes, you can represent a graph with a
> matrix or an  adjacency list, both representable as  arrays in one way
> or another.  Nothing in a digital computer cannot be represented by an
> array of  bits anyway!   But useability of  the interface must  not be
> ignored.
>

I am not sure where you see the problem - consider a PCI bus and all PCI
devices and all drivers tyhat currently present in kernel. They are using
the new driver model and sysfs and they come together quite nicely.

-- 
Dmitry
