Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbTEER56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTEER56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:57:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46019 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261164AbTEER54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:57:56 -0400
Message-ID: <3EB6A909.9090901@pobox.com>
Date: Mon, 05 May 2003 14:10:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Keniston <jkenisto@us.ibm.com>
CC: Joe Perches <joe@perches.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Janice Girard <girouard@us.ibm.com>, LOS team <losteam@intel.com>,
       Phil Cayton <phil.cayton@intel.com>, Randy Dunlap <rddunlap@osdl.org>,
       Larry Kessler <kessler@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Net device error logging
References: <3EB15849.D0E1556D@us.ibm.com>		 <1051816594.29929.32.camel@localhost.localdomain>		 <3EB1A718.1084972F@us.ibm.com> <1051894225.2664.62.camel@localhost.localdomain> <3EB3026C.604D6F4C@us.ibm.com>
In-Reply-To: <3EB3026C.604D6F4C@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston wrote:
> I'm happy to discuss this.  As I see it, there are at least 4
> possibilities:
> 1. Standardize on the netif_msg_xxx (bit map) approach.
> 2. Standardize on simple reporting levels (if (debug >= 2)...).
> 3. Make the driver provide a filtering function, which can do #1, #2 or
> some
> other driver-specific test.
> 4. Status quo: make the message-level test before calling netdev_xxx.

Number one is the desired direction for net drivers.




> I think message filtering is a good idea.  I also think the following
> features
> would be useful:
> a. Identify which device and driver the message refers to.

this is already done in net drivers


> b. Call net_ratelimit() in appropriate contexts.

this is questionable.  The netif_xxx messages are _already_ designed to 
be used in order of increasing verbosity.  If the user selects the more 
verbose class of messages, then rate-limiting may not be appropriate.


> c. Capture caller info (__FILE__ and/or __FUNCTION__).

No need, in net drivers.  All of them already print out network 
interface, which is all you need to know.


> e. Standardize certain messages so that all drivers log predictable,
> standard
> messages (perhaps along with driver-specific info) under certain
> circumstances.

Yes, standardization of net driver messages is desired.

	Jeff




