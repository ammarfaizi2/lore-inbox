Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269849AbRHQITF>; Fri, 17 Aug 2001 04:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269756AbRHQIS4>; Fri, 17 Aug 2001 04:18:56 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:2201 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S269849AbRHQISm>; Fri, 17 Aug 2001 04:18:42 -0400
From: Christoph Rohland <cr@sap.com>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about tmpfs
In-Reply-To: <20010817064809Z269735-760+2777@vger.kernel.org>
Organisation: SAP LinuxLab
Date: 17 Aug 2001 10:18:46 +0200
In-Reply-To: <20010817064809Z269735-760+2777@vger.kernel.org>
Message-ID: <m34rr79k0p.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, safemode@speakeasy.net wrote:
> I looked in the documentation for something about tmpfs and looked
> around for some obvious tmpfs source but couldn't find any to figure
> out how to know when/if it's doing what it's supposed to.  when i ls
> the dir it's mounted to i get nothing and this is what df gives me.
> Filesystem           1k-blocks    Used    Available Use% Mounted on
> tmpfs                   144108        0        144108       0%       /dev/shm

In the 2.3 timeframe SYSV shared memory did require you to mount shmfs
somewhere to work properly. This was relaxed since Al Viro introduced
kernel internal mount points. This feature is used now for SYSV shm
and shared anonymous maps. You do not see this instance in user
space. You can use ipcs to show the SYSV segmants.

The instance on /dev/shm only used by the shmopen/shmunlink functions
of glibc 2.2. These functions are specified by POSIX for shared memory
handling. Since there aren't a lot of programs using this interface
right now, you do not see anything here and could drop this mount from
your fstab. But if you use such a program you will need a tmpfs
instance mounted somewhere (preferably under /dev/shm).

Greetings
		Christoph


