Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSLWLuN>; Mon, 23 Dec 2002 06:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSLWLuN>; Mon, 23 Dec 2002 06:50:13 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:1286 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S264001AbSLWLuM>;
	Mon, 23 Dec 2002 06:50:12 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Mon, 23 Dec 2002 03:58:16 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: ext3/jbd breaks md stacking in 2.4
Message-ID: <20021223035816.B9669@jose.vato.org>
Mail-Followup-To: Tim Pepper <tpepper>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://vato.org/~tpepper/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently noticed that ext3/jbd break md stacking by making invalid
assumptions about the buffer head's b_private pointer.  There is a
thread discussing this on the LVM mailing list at:

http://linux.msede.com/lvm_mlist/archive/2002/07/0028.html

Searching google and driver source it seems to me that as others have
noticed this they've worked around it by keeping their own pools of
buffer heads instead of simply stacking on the system buffer head.
This strikes me as inefficient and just plain ugly.

The ability to stack b_rdev, b_private and b_end_io is documented kernel
behaviour and therefore shouldn't break in 2.4.

The above link in particular is to a simple patch Andrew Morton suggested.
This patch has been in -ac for quite a while, but is listed as not
forwarded to Marcello (any reason Alan?).  Is there any chance of getting
this fix into mainline kernels?

Tim

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
