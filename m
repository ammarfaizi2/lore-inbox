Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWCWARA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWCWARA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWCWAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:16:59 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:40204 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964900AbWCWAQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:16:58 -0500
Message-ID: <4421E8F6.10507@vmware.com>
Date: Wed, 22 Mar 2006 16:16:54 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063752.889921000@sorel.sous-sol.org>
In-Reply-To: <20060322063752.889921000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> 1. We clear FS/GS before changing TLS entries and switching LDT, as
> otherwise the hypervisor will fail to restore thread-local values on
> return to the guest kernel and we take a slow exception path.
>   

This should not be needed.  You should clear FS/GS that match updated 
descriptors in your descriptor validation code instead.  And you will 
get better performance for both native and the hypervisor cases.
