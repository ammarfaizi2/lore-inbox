Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292391AbSCICSX>; Fri, 8 Mar 2002 21:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292395AbSCICSN>; Fri, 8 Mar 2002 21:18:13 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:14730 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S292391AbSCICSD>;
	Fri, 8 Mar 2002 21:18:03 -0500
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [bkpatch] do_mmap cleanup
In-Reply-To: <20020308185350.E12425@redhat.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020308185350.E12425@redhat.com>
Date: 09 Mar 2002 03:15:38 +0100
Message-ID: <m2y9h2mqph.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "benjamin" == Benjamin LaHaise <bcrl@redhat.com> writes:

benjamin> diff -Nru a/include/linux/mm.h b/include/linux/mm.h
benjamin> --- a/include/linux/mm.h	Fri Mar  8 18:46:34 2002
benjamin> +++ b/include/linux/mm.h	Fri Mar  8 18:46:34 2002
benjamin> @@ -492,20 +492,11 @@
benjamin> extern int do_munmap(struct mm_struct *, unsigned long, size_t);
benjamin> +extern long sys_munmap(unsigned long, size_t);

Please, don't do that, export another function that does exactly that.
sys_munmap is declared as asmlinkage, and some architectures (at
least ppc used to have) need especial code to be able to call
asmlinkage functions from inside the kernel.

Declaring a __sys_munmap() that does the work and is exported and then
sys_munmap to be only the syscall entry is better.

asmlinkage long sys_munmap(unsigned long addr, size_t len)


 
Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
