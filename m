Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130140AbRACV7u>; Wed, 3 Jan 2001 16:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbRACV7j>; Wed, 3 Jan 2001 16:59:39 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:26125 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130032AbRACV7V>; Wed, 3 Jan 2001 16:59:21 -0500
Date: Wed, 3 Jan 2001 22:57:04 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Dan Aloni <karrde@callisto.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
Message-ID: <20010103225704.W888@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>; from karrde@callisto.yi.org on Wed, Jan 03, 2001 at 11:13:31PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 11:13:31PM +0200, Dan Aloni wrote:
> It is known that most remote exploits use the fact that stacks are
> executable (in i386, at least).
> 
> On Linux, they use INT 80 system calls to execute functions in the kernel
> as root, when the stack is smashed as a result of a buffer overflow bug in
> various server software.
> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using printk.

Cool.

> --- linux/arch/i386/kernel/process.c	Wed Jan  3 22:57:42 2001
> +++ linux/arch/i386/kernel/process.c	Wed Jan  3 22:57:55 2001
> @@ -765,3 +765,8 @@
>  }
>  #undef last_sched
>  #undef first_sched
> +
> +void print_bad_syscall(struct task_struct *task)
> +{
> +	printk("process %s (%d) tried to syscall from an executable segment!\n", task->comm, task->pid);
                                                         ^^^^^^^^^^
I suppose this should read "writable"...

> +}


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
