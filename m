Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSGCX57>; Wed, 3 Jul 2002 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGCX56>; Wed, 3 Jul 2002 19:57:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:37125 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317287AbSGCX55>;
	Wed, 3 Jul 2002 19:57:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
In-reply-to: Your message of "Thu, 04 Jul 2002 00:26:36 +0200."
             <20020704002636.59071208.diegocg@teleline.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Thu, 04 Jul 2002 10:00:19 +1000
Message-ID: <9261.1025740819@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002 00:26:36 +0200, 
Diego Calleja <diegocg@teleline.es> wrote:
>On Tue, 2 Jul 2002 17:50:19 -0400 (EDT)
>Ryan Anderson <ryan@michonline.com> escribió:
>
>> In a single processor, no preempt kernel, there is no race.
>> Turn on SMP or preempt and there is one.
>
>So we _can't_ talk about remove module removal, but _disabling_ module
>removal in the worst case.
>
>Because if the above is correct, single processors without preempt works
>well and can use module removal safely...

Module removal is not safe even on UP without preempt.  UP with no
preempt only removes this race

Read usecount
                        Enter module
                        Increment usecount
Check usecount == 0
Clean up module

There are other race conditions on module unload, which is why the
problem is so "interesting".

