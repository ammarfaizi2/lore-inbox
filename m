Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbTC0POY>; Thu, 27 Mar 2003 10:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTC0POY>; Thu, 27 Mar 2003 10:14:24 -0500
Received: from mail1-3.netinsight.se ([212.247.11.2]:7952 "HELO
	ernst.netinsight.se") by vger.kernel.org with SMTP
	id <S261942AbTC0POU>; Thu, 27 Mar 2003 10:14:20 -0500
Message-ID: <3E831774.D494DAE7@netinsight.se>
Date: Thu, 27 Mar 2003 16:23:32 +0100
From: Stephane <stephane.tessier@netinsight.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-16mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stephane Tessier <stephane.tessier@netinsight.se>
Subject: Re: exit_mmap
References: <3E830EC7.651EB9CE@netinsight.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I was talking about 2.4.19 but I saw that this was solved in
2.5,
sorry for the disturbance

Stephane wrote:
> 
> I have a question about mmap and the close operation of a
> vm_area_struct.
> Is there a reason why in exit_mmap, when a process dies unexpectedly,
> the vm_ops->close is called before zap_page_range is called?
> 
> The problem is that if you have allocated one or several kernel pages
> for a vm_area_struct, you can not free them in the vm_ops->close
> operation since the count field of the pages is not 0 because they are
> still mapped. The count will be cleared when zap_page_range is called.
> 
> This means that exit_mmap calls vm_ops->close and zap_page_range in the
> reverse order of a normal execution of the process, that is when the
> process unmap the area before dying.
> 
> It would be more deterministic and simple if vm_ops->close was always
> called when all the pages of the area was unmapped.
> 
> PS: please can you CC'ed the answer to stephane.tessier@netinsight.se
> --
> Stephane Tessier
> Net Insight AB          stephane.tessier@netinsight.se
> Västberga Allé 9        http://www.netinsight.se
> SE-126 30 Hägersten     phone:+46-8-685 04 60
> Sweden                  fax:  +46-8-685 04 20

-- 
Stephane Tessier
Net Insight AB          stephane.tessier@netinsight.se
Västberga Allé 9        http://www.netinsight.se
SE-126 30 Hägersten     phone:+46-8-685 04 60
Sweden                  fax:  +46-8-685 04 20
