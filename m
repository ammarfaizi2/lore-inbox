Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUCVG7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUCVG7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:59:22 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:18954 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261786AbUCVG7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:59:20 -0500
Message-ID: <405E8FF6.5020607@kolumbus.fi>
Date: Mon, 22 Mar 2004 09:04:22 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH][2.6-mm] defer free_initmem() if we have no /init
References: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 22.03.2004 09:01:44,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 22.03.2004 09:00:47,
	Serialize complete at 22.03.2004 09:00:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>In the absence of /init and other nice boot goodies, we fall through to
>prepare_namespace() so we shall require initmem to complete boot.
>
>
>Index: linux-2.6.5-rc2-mm1/init/main.c
>===================================================================
>RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/init/main.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 main.c
>--- linux-2.6.5-rc2-mm1/init/main.c	21 Mar 2004 17:02:18 -0000	1.1.1.1
>+++ linux-2.6.5-rc2-mm1/init/main.c	21 Mar 2004 20:54:19 -0000
>@@ -586,8 +586,8 @@ static int free_initmem_on_exec_helper(v
> 	char c;
>
> 	sys_close(fd[1]);
>-	sys_read(fd[0], &c, 1);
>-	free_initmem();
>+	if (sys_read(fd[0], &c, 1) > 0)
>+		free_initmem();
> 	return 0;
> }
>  
>

But the above change makes the early init case to not free initmem, 
which was the whole purpose of the close_on_exec + read + broken pipe 
hassle, I think.



--Mika


