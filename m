Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTEXSYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTEXSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 14:24:43 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:32664 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S262303AbTEXSYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 14:24:42 -0400
Date: Sat, 24 May 2003 14:37:48 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-ID: <20030524183748.GA3097@earth.solarsys.private>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@stimpy.netroedge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to all kernel versions since w83781d was brought in from 
the lm_sensors project.

The subclients of w83781d are never registered with i2c_attach_client().
But, w83781d_detach_client() tries to i2c_detach_client() them anyway.
This was harmless, until i2c-core was "listified"... because the old
array method silently ignored the attempt to detach a non-existent client.

The latest lm_sensors CVS of w83781d has the necessary i2c_attach_client()
calls - not sure why they were removed during conversion to 2.5.x.  Do we
intend to attach these subclients or not?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

