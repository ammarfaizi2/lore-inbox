Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTEWALw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTEWALw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:11:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61152 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263461AbTEWALv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:11:51 -0400
Date: Thu, 22 May 2003 17:23:04 -0700 (PDT)
Message-Id: <20030522.172304.08334616.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305230213.39460.schlicht@uni-mannheim.de>
References: <200305230147.00730.schlicht@uni-mannheim.de>
	<20030522.164845.48515977.davem@redhat.com>
	<200305230213.39460.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Fri, 23 May 2003 02:13:34 +0200

   > Therefore, it was a complete error for anyone else to start using this
   > macro for other structures.
   
   So nobody should better use THIS_MODULE?!

No, it is exactly what they should use.

They should avoid using SET_MODULE_OWNER.

   For ME and many other driver developers SET_MODULE_OWNER does not belong to 
   netdevice, it belongs to the module infrastructure!
   
Then by changing SET_MODULE_OWNER you will break source backwards
compatability for every single network device driver out there,
something I was explicitly trying to avoid.

SET_MODULE_OWNER() is a bogus interface because it is typeless.

Therefore I suggest that you create macros specific to your individual
structures, and use these to achieve 2.4.x/2.5.x build compatability
in setting the ->owner field of such structs.
