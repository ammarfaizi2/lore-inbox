Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315852AbSEVPTs>; Wed, 22 May 2002 11:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316131AbSEVPTr>; Wed, 22 May 2002 11:19:47 -0400
Received: from ns.suse.de ([213.95.15.193]:28179 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315852AbSEVPTq>;
	Wed, 22 May 2002 11:19:46 -0400
Date: Wed, 22 May 2002 17:19:45 +0200
From: Dave Jones <davej@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522171945.E28394@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, paulus@samba.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu> <3CEBA2D4.4080804@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 03:53:24PM +0200, Martin Dalecki wrote:

 > > XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
 > > and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
 > All the cases you encounter above are cases where Linux
 > leaks a more palatable interface.

proc/cpuinfo -> /dev/cpu/n/cpuid driver
proc/mtrr -> /dev/cpu/mtrr if devfs is around, but given thats not the
 common case, there is no alternative.

 > /proc/cpuinfo for one could be replaced by dropping syslog
 > messages at a fixed file in /etc/ during boot 

userspace really should be using the per-cpu drivers.

 > it's static after all!.

In most cses, yes. However this is not going to stay the same forever..
1. hotplug CPUs
2. speedscaling work like cpufreq
3. enabling/disabling of features by poking /dev/cpu/n/msr is possible, and
   cpuinfo should reflect that (but currently doesn't)


    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
