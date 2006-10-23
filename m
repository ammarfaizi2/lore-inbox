Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWJWSu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWJWSu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWJWSu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:50:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15064 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965037AbWJWSuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:50:25 -0400
Subject: Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       devel@laptop.org, davidz@redhat.com, mjg59@srcf.ucam.org,
       len.brown@intel.com, sfr@canb.auug.org.au, benh@kernel.crashing.org
In-Reply-To: <20061023183048.GA13804@kroah.com>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <20061023183048.GA13804@kroah.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 19:50:15 +0100
Message-Id: <1161629415.19446.397.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 11:30 -0700, Greg KH wrote:
> On Mon, Oct 23, 2006 at 07:20:33PM +0100, David Woodhouse wrote:
> > At git://git.infradead.org/battery-2.6.git there is an initial
> > implementation of a battery class, along with a driver which makes use
> > of it. The patch is below, and also viewable at 
> > http://git.infradead.org/?p=battery-2.6.git;a=commitdiff;h=master;hp=linus
> > 
> > I don't like the sysfs interaction much -- is it really necessary for me
> > to provide a separate function for each attribute, rather than a single
> > function which handles them all and is given the individual attribute as
> > an argument? That seems strange and bloated.
> 
> It is, but no one has asked for it to be changed to be like the struct
> device attributes are.  In fact, why not just use the struct device
> attributes here instead?  That will be much easier and keep me from
> having to convert your code over to use it in the future :)

Heh, OK. I'll look at that. Thanks.

> > I'm half tempted to ditch the sysfs attributes and just use a single
> > seq_file, in fact.
> 
> Ick, no.  You should use the hwmon interface, and standardize on a
> proper battery api just like those developers have standardized on other
> sensor apis that are exported to userspace.  

Er, yes. The whole point in this is so we can standardise on a proper
battery API. I'm only really supposed to be adding support for the
battery on the $100 laptop, but I just couldn't bring myself to do yet
another different battery driver without trying to bring in some sanity.

I sincerely hope that those responsible for the various other different
userspace interfaces for PMU, ACPI, etc. are all hanging their heads in
shame at this point :)

-- 
dwmw2

