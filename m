Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWIESuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWIESuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWIESuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:50:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:28906 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030213AbWIESuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:50:22 -0400
Date: Tue, 5 Sep 2006 13:50:20 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060905185020.GD7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com> <1157360592.22705.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157360592.22705.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 07:03:12PM +1000, Benjamin Herrenschmidt wrote:
> 
> > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > They just have different 3 bit function number. We could deduce if functions are in the same
> > device (slot).
> 
> Until you have a P2P bridge ...

And this is not theoretical: for example, the matrox graphics cards:

0000:c8:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
0000:c9:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

Now, I could have sworn there was another device behind this bridge, 
some serial or joystick controller or something, although this
particular card doesn't seem to have it.

------
It's not clear to me what hardware may show up in the future. 
For example, someone may build a 32x PCI-E card that will act 
as a bridge to a drawer with half-a-dozen ordinary PCI-X slots 
in it. This is perhaps a bit hypothetical, but changing the API 
will make it harder to implement eror recovery for such a system.

FWIW, there is at least one pSeries system in the lab which has
several hundred PCI slots attached to it, although I've never 
done testing on it. Hmm. Maybe its time I did ... 

--linas

