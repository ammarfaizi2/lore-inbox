Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279661AbRKIKjZ>; Fri, 9 Nov 2001 05:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279813AbRKIKjP>; Fri, 9 Nov 2001 05:39:15 -0500
Received: from smi-105.smith.uml.edu ([129.63.206.105]:44560 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S279808AbRKIKjB>;
	Fri, 9 Nov 2001 05:39:01 -0500
Date: Fri, 9 Nov 2001 05:39:00 -0500
From: Alex Pennace <alex@pennace.org>
To: Anumula Venkat <anumulavenkat@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ELF doubt
Message-ID: <20011109053900.A29926@buick.pennace.org>
Mail-Followup-To: Anumula Venkat <anumulavenkat@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011109061144.50768.qmail@web12005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011109061144.50768.qmail@web12005.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:11:22PM -0800, Anumula Venkat wrote:
>    Though it may not be question related to this group
> i am asking this question. Kindly clarify me.
> 
> I am reading runtime image of kernel module from
> another module. I heard that First 52 bytes will bw
> ELF header. But i got strange values. Can somebody
> clarify my doubt.

My understanding may be flawed.

linux/vmlinux is an ELF file with a full symbol table; nm uses this to
make System.map. linux/vmlinux is made by the linker folliwng the
instructions in a linker file; this linker file tells the linker
"ignore your defaults, the image does not start at absolute virtual
address 0x804800, it starts here." It also tells the linker how to
shuffle about special kernel sections, like .text.init and .data.init.

Now that the code knows where it will be in memory, nm is run to make
System.map. Then the architecture-specific boot stuff takes over. At
some point the equivalent of "objcopy -O binary" is run on
linux/vmlinux. This strips all the ELF stuff out, leaving code that
still expects to be loaded at the address it was destined for. This
ELF-less image is what you are reading in memory.
