Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWEEUnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWEEUnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWEEUnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:43:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:64933 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751216AbWEEUnP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:43:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JkloSwxJR8weMw2NGhxe2D81e/wbY6Rm6eerdigua2evKZAcX1J5y4FgN45drXDenhY++gpWHBkB1esRnSsa9ra4OHJgJTgrG7JoEhKFjL45RST6cLAvpb+rWO7ere/Cj5YcPXSW6BhfZ7qP7IQ1E6ckcBxbKPXSCKCorKnGlJQ=
Message-ID: <9e4733910605051343k3213d3f6ma4673ab0650272ea@mail.gmail.com>
Date: Fri, 5 May 2006 16:43:15 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605041326.36518.bjorn.helgaas@hp.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
	 <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/5/06, Greg KH <greg@kroah.com> wrote:
> > Who cares who "enabled" the device.  Remember, the majority of PCI
> > devices in the system are not video ones.  Lots of other types of
> > devices want this ability to enable PCI devices from userspace.  I've
> > been talking with some people about how to properly write PCI drivers in
> > userspace, and this attribute is a needed part of it.

The problem is not who 'enabled' the device. The problem is who owns
the state that has been loaded into the device. Without a mechanism
like open there is no way to serialize the programs trying to set
state into the device.

fbdev and X have this fight currently. On every VT swap they each
reload their state into the video hardware. There is no coordination
so both systems have to assume worst case and rebuild everything. This
is not a good environment to program in. Every time one of the systems
starts using some new feature of hardware (like acceleration
functions) new state recovery code needs to be written.

--
Jon Smirl
jonsmirl@gmail.com
