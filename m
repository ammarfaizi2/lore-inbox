Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTESRIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTESRIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:08:40 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:33511 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262499AbTESRIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:08:39 -0400
Date: Mon, 19 May 2003 11:08:32 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: try_then_request_module
Message-ID: <20030519110832.G626@nightmaster.csn.tu-chemnitz.de>
References: <20030519014233.5BF032C08C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030519014233.5BF032C08C@lists.samba.org>; from rusty@rustcorp.com.au on Mon, May 19, 2003 at 11:41:20AM +1000
X-Spam-Score: -3.7 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19HoKO-0000BD-00*TjJY0J2qyCI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
hi LKML,

On Mon, May 19, 2003 at 11:41:20AM +1000, Rusty Russell wrote:
> If someone is feeling eager, many callers could change to
> try_then_request_module(), eg:

[search || request_module]

Many implementation do this with a search and retry the search 
(if clever with a goto and a flag variable to save kernel size)
after module loading.

All that implemented in the search routine, which you have to
supply anyway.

So try_then_request_module() will consolidate the the
branch or in the worst case just duplicating that code
everywhere (depends on wether you implement it as a non-inline
function or define).

Usally this is all as simple as:

   int module_loaded_flag=0;
retry_with_module_loaded:
   
   /* search code */
   
   if (!module_loaded_flag && !found) {
      module_loaded_flag=1;
      if (!request_module(bla))
         goto retry_with_module_loaded;
   }
   return found;


which is very space effecient and also still readable.

Regards

Ingo Oeser
