Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDYTSj>; Wed, 25 Apr 2001 15:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDYTSV>; Wed, 25 Apr 2001 15:18:21 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:24051 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S131733AbRDYTSR>; Wed, 25 Apr 2001 15:18:17 -0400
Message-ID: <3AE72344.97C849DA@kegel.com>
Date: Wed, 25 Apr 2001 12:19:32 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <3AE704FA.DCF1BEC6@kegel.com> <01042520555600.00849@cookie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> 
> On Wednesday 25 April 2001 19:10, you wrote:
> > The command
> >   more foo/* foo/*/*
> > will display the values in the foo subtree nicely, I think.
> 
> Unfortunately it displays only the values. Dumping numbers and strings
> without knowing their meaning (and probably not even the order) is not very
> useful.

The meanings should be implied by the filenames, which are displayed (try it).
The order is alphabetical by filename.

> But the one-value per file approach is MORE work. It would be less work to
> create XML and factor out the directory structure in user-space :)
> Devreg collects its data from the drivers, each driver should contribute the
> information that it can provide about the device.
> Printing a few values in XML format using the functions from xmlprocfs is as
> easy as writing
> proc_printf(fragment, "<usb:topology port=\"%d\" portnum=\"%d\"/>\n",
>                 get_portnum(usbdev), usbdev->maxchild);

The corresponding one-value-per-file approach can probably be made to
be a single call per value.  IMHO that's more useful; it means that
(once we agree on definitions) programs don't need to parse XML to
access this data; they can go straight to the node in the document object
model tree ( = /proc ).  Think of /proc as a preparsed XML tree
that hasn't been standardized yet.
 
> The code is easy to read and not larger than a solution that creates static
> /proc entries, and holding the data completely static would take much more
> memory. And it takes less code than a solution that would create the values
> in /proc dynamically because this would mean one callback per file or a
> complicated way to specify several values with a single callback.

... but XML parsing is something we don't want to force on people
when we can provide the same data in a pre-parsed, much easier to access
form, IMHO.

Have you bothered to go back and read the old discussions on this topic?

> The driver should use its 
> own XML namespace, so whatever the driver adds will not break any 
> (well-written) user-space applications.

Are you trying to avoid writing a DTD?  IMHO it would be better to
have a single DTD for the entire tree, rather than a separate 
anything-goes namespace for each driver.  Yes, this is more work,
but all the Linux drivers are tightly integrated into the kernel
source tree, we may as well have a tightly-integrated DTD documenting
what each block, serial, synch, etc. driver must provide.

I think we both agree that there needs to be an easy, standardized way
to access this data.  IMHO there's a lot of standardizing that needs
to happen before you can start writing code -- otherwise your new code
won't help, and we'll be in the same mess we're in now.

The DTD can apply to both the existing /proc form and any proposed XML form
of config info exported by the kernel; there should be an easy transformation
between them.  And it has to come first!

- Dan
