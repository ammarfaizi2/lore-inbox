Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWG0REi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWG0REi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWG0REi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:04:38 -0400
Received: from xenotime.net ([66.160.160.81]:59581 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751769AbWG0REh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:04:37 -0400
Date: Thu, 27 Jul 2006 10:04:34 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Joe Jin <lkmaillist@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, ipw2100-admin@linux.intel.com,
       linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>,
       wim.coekaerts@oracle.com, wangwengang1976@gmail.com
Subject: Re: [PATCH]: Add check return result while call create_workqueue()
 for ipw2200
In-Reply-To: <Pine.LNX.4.58.0607270953340.7955@shark.he.net>
Message-ID: <Pine.LNX.4.58.0607271002510.7955@shark.he.net>
References: <215036450607270607o4955f3cau19669ab9c90e0e94@mail.gmail.com>
 <Pine.LNX.4.58.0607270953340.7955@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Randy.Dunlap wrote:

> On Thu, 27 Jul 2006, Joe Jin wrote:
>
> > Add check return result on call create_workqueue().
> >
> > Signed-off-by: Joe Jin <lkmaillist@gmail.com>
> > ---
> >
> > --- linux-2.6.17.7/drivers/net/wireless/ipw2200.c       2006-07-27
> > 20:27:01.000000000 +0800
> > +++ linux.new/drivers/net/wireless/ipw2200.c    2006-07-27
> > 20:28:22.000000000 +0800
> > @@ -10139,6 +10139,9 @@
> >         int ret = 0;
> >
> >         priv->workqueue = create_workqueue(DRV_NAME);
> > +       if(NULL == priv->workqueue){
> > +               return -ENOMEM;
> > +       }
>
> Makes sense, but style needs some changes:
>
> a.  space after "if"
> b.  put NULL on righth side of ==, or use !priv->workqueue
> c.  no {} braces for one-line "blocks"
> d.  if braces were being used, put a space between ) and {
>
> And <ret> is useless (not needed) in that function unless the code
> is changed to have a single exit point.

One more thing:  the patch is whitespace-damaged.  Something
converted all tabs to spaces.  Could have been a mail client
or copy-and-paste...  Did you use the gmail web interface
or gmail via SMTP?  gmail web interface does not preserve
tabs AFAIK.

> >         init_waitqueue_head(&priv->wait_command_queue);
> >         init_waitqueue_head(&priv->wait_state);
> >

-- 
~Randy
