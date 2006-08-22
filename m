Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWHVObR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWHVObR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHVObR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:31:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:36296 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932267AbWHVObQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:31:16 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Tue, 22 Aug 2006 15:51:07 +0200
User-Agent: KMail/1.8.2
Cc: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
References: <200608221453.49667.ossthema@de.ibm.com> <200608221601.24882.arnd.bergmann@de.ibm.com>
In-Reply-To: <200608221601.24882.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608221551.08406.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 22 August 2006 16:01, Arnd Bergmann wrote:
> > +       u64 rpage = 0;
> > +       int ret;
> > +       int cnt = 0;
> > +       void *vpage = NULL;
> > +
> > +       ret = hw_queue_ctor(hw_queue, nr_pages, EHEA_PAGESIZE, wqe_size);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (cnt = 0; cnt < nr_pages; cnt++) {
> > +               vpage = hw_qpageit_get_inc(hw_queue);
> > +               if (!vpage) {
> > +                       ehea_error("hw_qpageit_get_inc failed");
> > +                       goto qp_alloc_register_exit0;
> > +               }
> > +               rpage = virt_to_abs(vpage);
> 
> As someone mentioned before, the initialization to 0 or NULL
> is pointless here, as the variables are always assigned before
> they are used. There are a number of other places in your
> code that do similar things, you should probably go through
> these and remove the initializers.
> 
> If you indeed need something to be initialized, it is good practice
> to do the initialization as late as possible, e.g.
> 
> 	int foo;
> 	...
> 	foo = 0;
> 	do_foo(foo);
> 
> to make it clear that you have a reason to initialize it.
> 
> 	Arnd <><
> 

Agreed. We started to remove some but apparrently not all.
We'll go through the code and remove them where possible.

