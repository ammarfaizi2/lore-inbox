Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEQWTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEQWTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUEQWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:19:20 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:47069 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262951AbUEQWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:18:29 -0400
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040517151412.1f7fb7d4.akpm@osdl.org>
References: <20040517144603.1c63895f.rddunlap@osdl.org> 
	<20040517151412.1f7fb7d4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 May 2004 17:18:23 -0500
Message-Id: <1084832306.2092.67.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 17:14, Andrew Morton wrote:
> Why is it appropriate to register the MCA bus type when there is no
> MCA bus present?

The legacy bus functions all have a bus_for_each_dev in them.  This
can't execute correctly unless the bus is registered.  So either a check
for MCA_bus has to be added to each of them, or we register the bus but
attach no devices, so the loop exits without doing anything.

James


