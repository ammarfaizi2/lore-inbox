Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTIZUhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIZUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:37:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:39109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbTIZUhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:37:46 -0400
Subject: Re: IA32 - 6 New warnings (gcc 3.2.2)
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030926155654.GO15696@fs.tum.de>
References: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net>
	 <20030926155654.GO15696@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1064608625.10304.52.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Sep 2003 13:37:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2003-09-26 at 08:56, Adrian Bunk wrote:
> On Thu, Sep 25, 2003 at 10:48:35PM -0700, John Cherry wrote:
> >...
> > drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
> >...
> 
> Looking at the code, this seems to be a bogus warning in the gcc version
> you are using.
> 
> cu
> Adrian

Yes, this warning looks bogus.  Hard to understand why this was flagged
as a warning by gcc 3.2.2...

int sis_fb_alloc( DRM_IOCTL_ARGS )
{
        drm_sis_mem_t fb;
-->     struct sis_memreq req;
        int retval = 0;
                                                                                
        DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_mem_t *)data, sizeof(fb));
                                                                                
        req.size = fb.size;
-->     sis_malloc(&req);
        if (req.offset) {
                /* TODO */
                fb.offset = req.offset;
                fb.free = req.offset;
                if (!add_alloc_set(fb.context, VIDEO_TYPE, fb.free)) {
                        DRM_DEBUG("adding to allocation set fails\n");
                        sis_free(req.offset);
                        retval = DRM_ERR(EINVAL);
                }
        } else {
                fb.offset = 0;
                fb.size = 0;
                fb.free = 0;
        }
<snip>

John


