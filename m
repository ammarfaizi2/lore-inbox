Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291518AbSBHJtA>; Fri, 8 Feb 2002 04:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291510AbSBHJsv>; Fri, 8 Feb 2002 04:48:51 -0500
Received: from mail4.messagelabs.com ([212.125.75.12]:51205 "HELO
	mail4.messagelabs.com") by vger.kernel.org with SMTP
	id <S291509AbSBHJsl>; Fri, 8 Feb 2002 04:48:41 -0500
X-VirusChecked: Checked
Date: Fri, 8 Feb 2002 09:48:38 +0000 (GMT)
From: Catalin Marinas <c_marinas@yahoo.com>
X-X-Sender: marinasc@stargate.simoco.com
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Weird bug in linux, glibc, gcc or what?
In-Reply-To: <20020207135749.GA4545@sion.mty.itesm.mx>
Message-ID: <Pine.LNX.4.44.0202080942300.4228-100000@stargate.simoco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Felipe Contreras wrote:

> I've found a weird problem in linuxthreads. When I get out of a thread it
> happends one of three, the new thread get's defuct and the proccess never
> ends, it segfaults, or it works.
[snip]
> #include <pthread.h>
>
> void *test(void *arg) {
> 	puts("Thread2");
> 	return 0;
> }
>
> int main() {
> 	pthread_t tt;
> 	puts("Before Thread2");
> 	pthread_create(&tt,NULL,test,NULL);
> 	puts("After Thread2");
> 	return 0;
> }

Try this patch and see if it works:

--- thr_test.c	Fri Feb  8 09:45:35 2002
+++ thr_test1.c	Fri Feb  8 09:45:36 2002
@@ -10,5 +10,6 @@ int main() {
 	puts("Before Thread2");
 	pthread_create(&tt,NULL,test,NULL);
 	puts("After Thread2");
+	pthread_join(tt, NULL);
 	return 0;
 }

-- 
Catalin


________________________________________________________________________
This email has been scanned for all viruses by the MessageLabs SkyScan
service. For more information on a proactive anti-virus service working
around the clock, around the globe, visit http://www.messagelabs.com
________________________________________________________________________
