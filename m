Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbSJITvD>; Wed, 9 Oct 2002 15:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSJITvD>; Wed, 9 Oct 2002 15:51:03 -0400
Received: from gw.openss7.com ([142.179.199.224]:23563 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262074AbSJITvB>;
	Wed, 9 Oct 2002 15:51:01 -0400
Date: Wed, 9 Oct 2002 13:54:42 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com
Subject: Re: [PATCH] Re: export of sys_call_table
Message-ID: <20021009135442.E16773@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com
References: <41C1FEE0A55@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41C1FEE0A55@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Oct 09, 2002 at 02:20:19PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

Thanks you for the constructive suggestions.  I'll see if we
can add those in an test it up.

--brian

On Wed, 09 Oct 2002, Petr Vandrovec wrote:

> On  8 Oct 02 at 18:21, Brian F. G. Bidulock wrote:
> > --- kernel/sys.c.orig   2002-08-02 19:39:46.000000000 -0500
> > +++ kernel/sys.c    2002-10-08 16:46:55.000000000 -0500
> ...
> 
> I believe that you should check that nobody else has registered its
> own streams module. You can also allow for multiple streams modules
> in parallel (and fall through when module returns on -ENOIOCTLCMD or -ENOTTY),
> but I believe that usually only one module will be registered.
> 
> And I believe that export symbols should NOT be _GPL_ONLY: before
> (non-GPL) export of syscall_table was available, non-GPL modules were
> able to hook syscalls, and when _GPL_ONLY was introduced into kernel
> it was promised that we'll never make currently provided functionality
> GPL-only (as far as I remember).
>                                                     Best regards,
>                                                         Petr Vandrovec
>                                                         
> int register_streams_calls(...)
> > +void register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
> > +               int (*getpmsg) (int, void *, void *, int, int))
> > +{
> 
> int err;
> if (!putpmsg || !getpmsg) return -EINVAL;
> 
> > +   down_write(&streams_call_sem);
> 
> err = -EBUSY;
> if (!do_putpmsg) {
>   err = 0;
> 
> > +   do_putpmsg = putpmsg;
> > +   do_getpmsg = getpmsg;
> 
> }
> 
> > +   up_write(&streams_call_sem);
> 
> return err;
> 
> > +}
> > +
> > +void unregister_streams_calls(void)
> > +{
> 
>    down_write(&streams_call_sem);
>    do_putpmsg = NULL;
>    do_getpmsg = NULL;
>    up_write(&streams_call_sem);
> }
>     

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
