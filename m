Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267500AbUBRPY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUBRPY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:24:26 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:57985 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S267500AbUBRPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:24:25 -0500
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20040217235431.GF6242@redhat.com>
	<wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org>
	<20040218111612.GM6242@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 18 Feb 2004 16:24:15 +0100
Message-ID: <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040218111612.GM6242@redhat.com> (Dave Jones's message of
 "Wed, 18 Feb 2004 11:16:12 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> This problem is not just cosmetic btw, it kills boxes.
Dave> For example, hp100 is a net driver that supports multiple busses.
Dave> Trying to modprobe it on a kernel that supports EISA on a box that
Dave> doesn't gets a hung modprobe. Backtrace shows..

[...]

It looks like hp100 is at least broken wrt probing, since it lacks a
EISA-ID table terminator. What about changing it to :

static struct eisa_device_id hp100_eisa_tbl[] = {
        { "HWPF180" }, /* HP J2577 rev A */
        { "HWP1920" }, /* HP 27248B */
        { "HWP1940" }, /* HP J2577 */
        { "HWP1990" }, /* HP J2577 */
        { "CPX0301" }, /* ReadyLink ENET100-VG4 */
        { "CPX0401" }, /* FreedomLine 100/VG */
        { "" },        /* THIS ENTRY IS MANDATORY !!! */
};

Dave> I've seen same exactly the same behaviour with quite a few other
Dave> modules.  For my 'modprobe/rmmod script-o-death', I just ended
Dave> up disabling EISA in that test tree, as it was too painful to
Dave> hit this issue over and over, but its a real situation that
Dave> could bite users of for eg, vendor kernels.

What are the other modules ? I'd like to reproduce the problem (I have
no PCI hp100 to check if the above fixes the problem).

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
