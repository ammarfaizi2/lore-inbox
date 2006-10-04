Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWJDSCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWJDSCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161546AbWJDSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:02:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:29538 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422649AbWJDSCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:02:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVYaOPixn5OnQFdD69PXW2J51fEGAFiwsv6q3DOBNahD64xROrVWbLVmRfzrplQ20gVz+YjH817QIB9dI1KNz/DWLTL7PisPur5TbPuh+cOvfC6LVenUo9aLN5bCWs+pAZ1hWSIyp3ecsYhW+GURhvFRVRkdoc9AIG0xtLQX4RA=
Message-ID: <9a8748490610041102n69c5ee15s1c01675aca84625a@mail.gmail.com>
Date: Wed, 4 Oct 2006 20:02:29 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Ulrich Drepper" <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
In-Reply-To: <45229A99.6060703@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45150CD7.4010708@aknet.ru> <45169C0C.5010001@aknet.ru>
	 <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru>
	 <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org>
	 <451E3C0C.10105@aknet.ru>
	 <1159887682.2891.537.camel@laptopd505.fenrus.org>
	 <45229A99.6060703@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/06, Stas Sergeev <stsp@aknet.ru> wrote:
> Hello.
>
> Arjan van de Ven wrote:
> > no what bothers me that on the one hand you want no execute from the
> > partition, and AT THE SAME TIME want stuff to execute from there (being
> > libraries or binaries, same thing to me).
> The original problem came from "noexec" on /dev/shm
> mount. There is no library and no binary there, but
> the programs do shm_open(), ftruncate() and
> mmap(MAP_SHARED, PROT_EXEC) to get some shared memory
> with an exec perm. That fails.
>

So first you mount /dev/shm with 'noexec', thereby telling the system
"please make shared memory non executable".
Then an application goes and asks for executable shared memory, gets
denied and thus fails.  And that's a problem? It's exactely what you
asked for.

Either you want non-executable shared memory, so you mount /dev/shm
'noexec' or you want shared memory to be executable, in which case you
don't mount it 'noexec'.

As I see it, that's really all there is to it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
