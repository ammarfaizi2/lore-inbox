Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTIYGXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 02:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTIYGXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 02:23:45 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:55561 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261712AbTIYGXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 02:23:44 -0400
Date: Thu, 25 Sep 2003 07:23:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH} fix defect with kobject memory leaks during del_gendisk
Message-ID: <20030925072343.A4636@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
	mochel@osdl.org
References: <1064444526.13033.355.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064444526.13033.355.camel@persist.az.mvista.com>; from sdake@mvista.com on Wed, Sep 24, 2003 at 04:02:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 04:02:06PM -0700, Steven Dake wrote:
> Unfortunately it appears that del_gendisk uses kobject_del to delete the
> kobject.  If the kobject has a ktype release function, it is not called
> in the kobject_del call path, but only in kobject_unregister.

That's intentional.  gendisks (like everything using kobjects) are
reference counted and ->release is unly called after the last reference
goes away, for gendisks that would be the last put_disk call.

Unless you miss the put_disk call (which md certainly has) there's
no memeory leak.
