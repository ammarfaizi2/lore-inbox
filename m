Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWDZQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWDZQYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWDZQYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:24:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:19126 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964809AbWDZQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:24:16 -0400
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28058688:sNHT49725851"
Subject: Re: [patch] pciehp: dont call pci_enable_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1146066747.7016.17.camel@laptopd505.fenrus.org>
References: <1145919059.6478.29.camel@whizzy>
	 <1145945819.3114.0.camel@laptopd505.fenrus.org>
	 <1146002437.6478.43.camel@whizzy>
	 <1146066747.7016.17.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Apr 2006 09:32:44 -0700
Message-Id: <1146069164.25081.5.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 26 Apr 2006 16:23:17.0598 (UTC) FILETIME=[B9B987E0:01C6694D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 17:52 +0200, Arjan van de Ven wrote:
> On Tue, 2006-04-25 at 15:00 -0700, Kristen Accardi wrote:
> > On Tue, 2006-04-25 at 08:16 +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-04-24 at 15:50 -0700, Kristen Accardi wrote:
> > > > Don't call pci_enable_device from pciehp because the pcie port service driver
> > > > already does this.
> > > 
> > > hmmmm shouldn't pci_enable_device on a previously enabled device just
> > > succeed? Sounds more than logical to me to make it that way at least...
> > 
> > I can't think of any reason why not.  Something like this what you had
> > in mind perhaps?
> > 
> > ---
> 
> the question then becomes if enable/disable should become "counting", eg
> enable twice disable once leaves enabled at count one....

ugh, no.  1) I think we should avoid adding more counting unless it's
absolutely necessary. 2) if a device calls pci_disable_device it should
always actually disable the device, because it is generally called in
drivers either when the device is being shutdown, or suspended.

   
