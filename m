Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281090AbRKTWE0>; Tue, 20 Nov 2001 17:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281404AbRKTWEQ>; Tue, 20 Nov 2001 17:04:16 -0500
Received: from [208.132.17.2] ([208.132.17.2]:13831 "HELO aegis.indstorage.com")
	by vger.kernel.org with SMTP id <S281090AbRKTWEE>;
	Tue, 20 Nov 2001 17:04:04 -0500
From: n0ano@indstorage.com
Date: Tue, 20 Nov 2001 15:02:32 -0700
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy to user
Message-ID: <20011120150232.A890@tlaloc.indstorage.com>
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>; from umiguel@alunos.deis.isec.pt on Tue, Nov 20, 2001 at 08:54:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignoring the merits of what you are trying to do why don't you put your
new code on the target's stack?  This avoids all of the problems associated
with changing the code section (which is doable but tricky, after all if
`gdb' can change the code section you certainly could).

On Tue, Nov 20, 2001 at 08:54:42PM +0000, Luis Miguel Correia Henriques wrote:
> The reason that I need it to spend CPU time is that I'm developing a fault
> injector. The purpose of a fault injection tool is, as you could imagine,
> to test some critical systems and it's capacity to recover from fails. The
> reason for changing the code of a process is that process must be delayed
> but without leaving the CPU - everything must look like nothing wrong is
> happening, except for other processes that are waiting for something from
> the delayed process...
> 
> Maybe I should have explained this before... sorry.
> 
> I suppose now you can understand why SIGSTOP won't work. Hope you can help
> me :)
> 
> About using udelay... this soluction seemed fine to me at first but if I
> hang the CPU with udelay the scheduler will no be doing it's job (isn't
> it?). This would give me even more intrusiveness (another requirement: the
> less intrusiveness as possible).
> 
> Isn't there any doubt that copy_to_user can handle my problem? When I use
> it to change CS, this function returns the correct number of bytes (and no
> error) but, when I try to read... the old data is still there. I suppose
> there is a page/segment protection against writing to CS, isn't it?
> 
> Luis Henriques
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@indstorage.com
Ph: 303/652-0870x117
