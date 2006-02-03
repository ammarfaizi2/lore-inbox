Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWBCBfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWBCBfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWBCBfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:35:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12509 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751033AbWBCBfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:35:16 -0500
Date: Thu, 2 Feb 2006 20:33:57 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [patch -mm4] i386 cpu hotplug: don't access freed memory
Message-ID: <20060203013357.GA10209@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>, ashok.raj@intel.com,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <200602021904_MC3-1-B771-46F7@compuserve.com> <20060202165257.29dcfa20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202165257.29dcfa20.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 04:52:57PM -0800, Andrew Morton wrote:
 > Chuck Ebbert <76306.1226@compuserve.com> wrote:
 > >
 > > @@ -160,10 +162,17 @@ static void __cpuinit get_cpu_vendor(str
 > >  				c->x86_vendor = i;
 > >  				if (!early)
 > >  					this_cpu = cpu_devs[i];
 > > -				break;
 > > +				return;
 > >  			}
 > >  		}
 > >  	}
 > > +	if (!printed) {
 > > +		printed++;
 > > +		printk(KERN_ERR "CPU: Vendor unknown, using generic init.\n");
 > > +		printk(KERN_ERR "CPU: Your system may be unstable.\n");
 > > +	}
 > > +	c->x86_vendor = X86_VENDOR_UNKNOWN;
 > > +	this_cpu = &default_cpu;
 > 
 > Well that's a worry.  Under what circumstances (if any) will this final bit
 > of code get executed?

Some new x86 CPU vendor appears that we don't know about.

		Dave
