Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWHBWXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHBWXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWHBWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:23:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54446 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932290AbWHBWXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:23:30 -0400
Date: Wed, 2 Aug 2006 18:23:21 -0400
From: Dave Jones <davej@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com
Subject: Re: frequent slab corruption (since a long time)
Message-ID: <20060802222321.GH3639@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
	jbaron@redhat.com
References: <20060802021617.GH22589@redhat.com> <20060801.220538.89280517.davem@davemloft.net> <20060801.223110.56811869.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801.223110.56811869.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 10:31:10PM -0700, David Miller wrote:
 > From: David Miller <davem@davemloft.net>
 > Date: Tue, 01 Aug 2006 22:05:38 -0700 (PDT)
 > 
 > > The corruption is always a 32-bit 0xffffffff followed by
 > > a 32-bit 0x00000000, 12 bytes into the object.
 > 
 > This analysis is wrong, it's "0xb0 + 12" bytes into the object
 > which is 188 bytes.  For x86, this lands us at the "count"
 > member of the tty_struct, and it shows that the tty count
 > has decremented to -1 (0xffffffff) which is a serious bug.

<stabbing in the dark here>

None of the code manipulating tty->count seems to be under
the tty_mutex.  Should it be ?
Or is this protected through some other means?

Jason, ISTR you've done some digging around this area wrt races,
any insight ?

		Dave

-- 
http://www.codemonkey.org.uk
