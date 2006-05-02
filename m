Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWEBV7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWEBV7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEBV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:59:55 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13704 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965016AbWEBV7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:59:54 -0400
Date: Tue, 2 May 2006 23:55:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Message-ID: <20060502215559.GA1119@electric-eye.fr.zoreil.com>
References: <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI> <20060502214520.GC26357@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502214520.GC26357@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw the whole serie is available in branch 'netdev-ipg' at:
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git

The interim steps may be useful if testing reveals something wrong
(especially if it happens in a few weeks/months).

$ git rev-list --pretty ebf34c9b6fcd22338ef764b039b3ac55ed0e297b..HEAD 

commit 8a98963033425729158d48066a3380f811c711b3
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 23:25:44 2006 +0200

    ipg: redundancy with mii.h
    
    Replace a bunch of #define with their counterpart from mii.h
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 291360d4000e0b93baf0fb97aa15af48677e46af
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 22:15:34 2006 +0200

    ipg: sanitize the pci device table
    
    - vendor id belong to include/linux/pci_id.h ;
    - the pci table does not include all the devices in nics_supported ;
    - qualify the pci table as __devinitdata ;
    - kill 50 LOC.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 8b534f66d6be247b9f0d341b0ae7acbf46f128fb
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 01:07:48 2006 +0200

    ipg: plug leaks in the error path of ipg_nic_open
    
    Added ipg_{rx/tx}_clear() to factor out some code.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 87c8b13dceccc42439e7262f1b60c9cbb14d5440
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Tue May 2 00:15:54 2006 +0200

    ipg: leaks in ipg_probe
    
    The error paths are badly broken.
    
    Bonus:
    - remove duplicate initialization of sp;
    - remove useless NULL initialization of dev;
    - USE_IO_OPS is not used (and the driver does not seem to care about
      posted writes, rejoice).
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit befd7e543fcdfb2d2c75de1748ae751fefdff58a
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Mon May 1 23:52:37 2006 +0200

    ipg: removal of unreachable code
    
    map/unmap is done in ipg_{probe/remove}
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 17a9ce93ba6b6744489aa9168d757e9457158952
Author: Romieu Francois <romieu@fr.zoreil.com>
Date:   Mon May 1 22:40:29 2006 +0200

    ipg: speed-up access to the PHY registers
    
    Reduce delays when reading/writing the PHY registers so we clock the
    MII management interface at 2.5 MHz (the maximum according to the
    datasheet) instead of 500 Hz.
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit e18c33d6fa62b735426b8fe5a0f1aa61c0b5d7f7
Author: David Vrabel <dvrabel@cantab.net>
Date:   Mon May 1 21:34:19 2006 +0200

    ipg: root_dev removal and PHY initialization
    
    - Remove ether_crc_le() -- use crc32_le() instead.
    - No more nonsense with root_dev -- ipg_remove() now works.
    - Move PHY and MAC address initialization into the ipg_probe().
      It was previously filling in the MAC address on open which breaks
      some user space.
    - Folded ipg_nic_init into ipg_probe since it was broke otherwise.
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit e99fcd4253f231b2c7a96e3be5067341de45ac2e
Author: David Vrabel <dvrabel@cantab.net>
Date:   Mon May 1 13:20:49 2006 +0200

    ipg: remove changelogs
    
    Signed-off-by: David Vrabel <dvrabel@cantab.net>

commit 8fd59026a272d3132f096965985e907d655ee087
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Mon May 1 12:53:43 2006 +0200

    ipg: initial inclusion of IC Plus IP1000 driver
    
    This is a cleaned up fork of the IP1000A device driver:
    
      <http://www.icplus.com.tw/driver-pp-IP1000A.html>
    
    Open issues include but are not limited to:
    
      - ipg_probe() looks really fishy and doesn't handle all errors
        (e.g. ioremap failing).
      - ipg_nic_do_ioctl() is playing games with user-space pointer.
        We should use ethtool ioctl instead as suggested by Arjan.
      - For multiple devices, the driver uses a global root_dev and
        ipg_remove() play some tricks which look fishy.
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

