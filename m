Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSJZAhI>; Fri, 25 Oct 2002 20:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJZAhI>; Fri, 25 Oct 2002 20:37:08 -0400
Received: from smtp08.iddeo.es ([62.81.186.18]:27111 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261714AbSJZAhH>;
	Fri, 25 Oct 2002 20:37:07 -0400
Date: Sat, 26 Oct 2002 02:43:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021026004320.GA1676@werewolf.able.es>
References: <F2DBA543B89AD51184B600508B68D4000ECE70C8@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE70C8@fmsmsx103.fm.intel.com>; from jun.nakajima@intel.com on Sat, Oct 26, 2002 at 01:59:29 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.26 "Nakajima, Jun" wrote:
>RedHat 8.0 is using
>	"Physical processor ID\t:"
>	"Number of siblings\t:"
>This implies they need to change it anyway, because 2.4-ac is
>	"physical id\t:"
>	"siblings\t:"
>

Summary:
- we have processor packages
- each package can handle several (someone said 128+ ;) ) processor cores.
  We really do not mind if they are really independent (power4) or not
  (xeon, ht)
- each core is a logical unit for Linux
- can we have two packages with different number of cores ?

Proposal for /proc/cpuinfo (sample box: an hypothetical TurboPower4 with
4 cores, 2 units on an SMP box):

processor : 0  processor : 2  processor : 4  processor  : 6 
package   : 0  package   : 0  package   : 0  package    : 0  
core      : 0  core      : 1  core      : 2  core       : 3  

processor : 1  processor : 3  processor : 5  processor  : 7 
package   : 1  package   : 1  package   : 1  package    : 1  
core      : 0  core      : 1  core      : 2  core       : 3  

So you can look for siblings based on package number, you can know if
two precessors are in different packages (for sched...), etc.

NOTE: do not know if 'core' name can give problems, perhaps you could use
'unit' instead.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
