Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWE3ShV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWE3ShV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWE3ShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:37:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:21725 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932374AbWE3ShU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:37:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lj3+1KMqJsosHafWvL4yDGMQ4Nrlt6h6tl+asU6iAQM07OnUOEOjTeQmY6+8HE31nKW6TEZy2PtEP6DiObcr8uHOgfubicobUuOmy4L0IEk/9dpmomNnqum326MP4SW5PU3n64Wm8NU77yttF4qRhTfd9fAbY4S8UKkPm12xrh0=
Message-ID: <d120d5000605301137h883eebi3c4ede13ab7ff3e1@mail.gmail.com>
Date: Tue, 30 May 2006 14:37:20 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: linux-kernel@vger.kernel.org
Subject: Confused about section type conflicts and __initdata
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to declare dmi_ids in drivers/input/misc/wistron_btns.c as
__initdata but gcc keeps bitching about
"drivers/input/misc/wistron_btns.c:326: error: dmi_ids causes a
section type conflict" unless I also declare that variable as "const".
I checked GCC's assembler output and using "static const struct
dmi_system_id __initdata dmi_ids[] = {..." does indeed get it into
".init.data" section but comments in include/linux/init.h specifically
mention that the data can't be const... This is with GCC 3.4.4.

Anyone have any ideas, pretty please?

-- 
Dmitry
