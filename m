Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266348AbUGAW3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUGAW3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUGAW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:29:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37830 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266348AbUGAW3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:29:09 -0400
Subject: Re: PPC64: vio_find_node removal?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
In-Reply-To: <200407011454.55440.dtor_core@ameritech.net>
References: <200407011454.55440.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1088720772.22742.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jul 2004 17:26:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 14:54, Dmitry Torokhov wrote:

> kset_find_obj that is now only used by vio_find_name/vio_find_node needs to
> take kobject reference otherwise use of this function is generally unsafe.
> 
> I was looking at vio_find_name users and it is only used in rpaphp hotplug
> driver. When creating a hotplug slot the function first tries to find already
> existing vio node and if unsuccessfull tries to create a new one. The only
> time when vio node would already exist if previous call to register_vio_slot
> failed (the function does not do cleanup of created vio device node and it's
> the only place where vio devices are created). So it seems to me that if
> register_vio_slot would do proper cleanup we can get rid of vio_find_name/
> vio_find_node.

At boot time, all the virtual IO devices are registered and matched with
their drivers (or not). Later on (possibly when loading a module),
rpaphp initializes. rpaphp needs a reference to the already-registered
VIO devices so that it can hotplug-remove them later by calling
vio_unregister_device().

-- 
Hollis Blanchard
IBM Linux Technology Center

