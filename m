Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbSJJQ1L>; Thu, 10 Oct 2002 12:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261680AbSJJQ1L>; Thu, 10 Oct 2002 12:27:11 -0400
Received: from email.gcom.com ([206.221.230.194]:6587 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S261658AbSJJQ1K>;
	Thu, 10 Oct 2002 12:27:10 -0400
Message-Id: <5.1.0.14.2.20021010113155.026a55f8@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 11:32:48 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com, bidulock@openss7.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patch was "better" but not correct.  How about this? (changed 
return 0 to return ret).

int register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
                             int (*getpmsg) (int, void *, void *, int, int))
{
         int ret = 0;
         down_write(&streams_call_sem) ; /* should return int, but doesn't */
         if (   (putpmsg != NULL && do_putpmsg != NULL)
             || (getpmsg != NULL && do_getpmsg != NULL)
            )
                 ret = -EBUSY;
         else {
                 do_putpmsg = putpmsg;
                 do_getpmsg = getpmsg;
         }
         up_write(&streams_call_sem);
         return ret ;
}

