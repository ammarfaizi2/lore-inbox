Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVAJUUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVAJUUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAJUT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:19:57 -0500
Received: from colin2.muc.de ([193.149.48.15]:23813 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262474AbVAJUTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:19:00 -0500
Date: 10 Jan 2005 21:18:59 +0100
Date: Mon, 10 Jan 2005 21:18:59 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110201859.GB98279@muc.de>
References: <3174569B9743D511922F00A0C9431423072913A4@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C9431423072913A4@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 12:09:48PM -0800, YhLu wrote:
> Try this one.

I don't think it will work at all on Intel HT systems, since
nobody initializes c->x86_num_cores there. phys_proc_id[] 
is supposed to be the same on two HT siblings.

You'll either need to initialize c->x86_num_cores on Intel too.
But since Intel seems to have dual cores upcomming and you'll
want HyperThreading support too it would need to be a new field.

Alternatively you can split the function for AMD and Intel and
use the new algorithm on AMD only.  Perhaps that's better.
In the later case I would only use it when CMP_LEGACY is set.  

-Andi
