Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbREWKYg>; Wed, 23 May 2001 06:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbREWKYZ>; Wed, 23 May 2001 06:24:25 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:54552 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S261685AbREWKYU>; Wed, 23 May 2001 06:24:20 -0400
Message-ID: <3B0B8FCE.E0677CD0@stud.uni-saarland.de>
Date: Wed, 23 May 2001 10:24:14 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: avivg@voltaire.com
CC: linux-kernel@vger.kernel.org
Subject: Re: softirq question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to enter into sleep mode 
> ( current->state = !RUNNING && schedule(_timeout)) 
> from a softirq ? 

calling schedule() causes a panic() in schedule(), and even an innocent

	current->state = TASK_RUNNING;

from an softirq causes runqueue corruptions.[you must use
wake_up_process() since it's not guaranteed that 'current' is actually
in the runqueue.]

--
	Manfred
