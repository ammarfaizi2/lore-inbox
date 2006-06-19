Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWFSXs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWFSXs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFSXs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:48:59 -0400
Received: from relay2.uli.it ([62.212.1.5]:12684 "EHLO relay2.uli.it")
	by vger.kernel.org with ESMTP id S932512AbWFSXs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:48:59 -0400
From: Daniele Orlandi <daniele@orlandi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Passing references to kobjects between userland and kernel
Date: Tue, 20 Jun 2006 01:48:54 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200606141626.39273.daniele@orlandi.com> <20060616235800.GA29573@kroah.com>
In-Reply-To: <20060616235800.GA29573@kroah.com>
X-Message-Flag: Outlook puo' causare gravi danni alla salute. Pensaci.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606200148.56117.daniele@orlandi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 June 2006 01:58, Greg KH wrote:
>
> Use the kobject_uevent() call from kernelspace to let userspace know
> whatever you want it to.  That is what it is there for :)

kobject_uevent() is fine if I want to asynchronously notify the user space of 
an event.

What I need is a synchronous bidirectional interface, e.g. I tell the kernel 
"connect node X with node Y" and I get back the resulting pipeline 
identifier.

> Or use configfs :)

Configfs is very interesting, it's surely well suited for several tasks I'm 
doing and I will add support for it into my subsystem.

What it's missing is the ability to create non-persistent configurations, 
bound to a process and disappearing along with the process that created them.

For example, my process creates pipelines between nodes using a ioctl() 
interface. If the process dies unexpectedly the file descriptor is 
automatically closed and I can release all the pipelines. I don't see a way I 
could accomplish the same with configfs or sysfs. 

OTOH, for what concerns persistent pipelines, configfs is quite good. It would 
be even better if I could create links from configfs objects to sysfs 
objects.

Bye,

-- 
  Daniele "Vihai" Orlandi
