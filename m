Return-Path: <linux-kernel-owner+w=401wt.eu-S932924AbWL0GIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbWL0GIp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 01:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932926AbWL0GIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 01:08:44 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:38766 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbWL0GIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 01:08:44 -0500
Subject: Re: Feature request: exec self for NOMMU.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Rob Landley <rob@landley.net>
Cc: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
In-Reply-To: <200612270051.52690.rob@landley.net>
References: <200612261823.07927.rob@landley.net>
	 <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
	 <200612270051.52690.rob@landley.net>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 22:08:36 -0800
Message-Id: <1167199716.5616.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 00:51 -0500, Rob Landley wrote:
> On Wednesday 27 December 2006 12:13 am, Ray Lee wrote:
> > How about openning an fd to yourself at the beginning of execution, then
> > calling fexecve later?
> 
> I haven't got a man page for fexecve.  Does libc have it?

It's implemented inside glibc, and uses /proc to execve() the file that
the fd points to. Here's the code from
sysdeps/unix/sysv/linux/fexecve.c:

fexecve (fd, argv, envp)
     int fd;
     char *const argv[];
     char *const envp[];
{
  ...
  /* We use the /proc filesystem to get the information.  If it is not
     mounted we fail.  */
  char buf[sizeof "/proc/self/fd/" + sizeof (int) * 3];
  __snprintf (buf, sizeof (buf), "/proc/self/fd/%d", fd);

  /* We do not need the return value.  */
  __execve (buf, argv, envp);
  ...
}


