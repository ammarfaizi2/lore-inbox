Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131022AbQLMRqW>; Wed, 13 Dec 2000 12:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131866AbQLMRp5>; Wed, 13 Dec 2000 12:45:57 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:23715 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130639AbQLMRpm>; Wed, 13 Dec 2000 12:45:42 -0500
From: Christoph Rohland <cr@sap.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <23640.976725805@warthog.cambridge.redhat.com>
Organisation: SAP LinuxLab
Date: 13 Dec 2000 18:15:02 +0100
In-Reply-To: David Howells's message of "Wed, 13 Dec 2000 16:43:25 +0000"
Message-ID: <qwwn1e0i6p5.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, 13 Dec 2000, David Howells wrote:
> Looks interesting.
> 
> There looks to be a logical mapping between CreateFileMapping() +
> MEM_SHARED and your shmem_file_setup(), as long as anonymously named
> sections are catered for (not difficult).

Yup.

> There also looks to be a logical mapping between MapViewOfFile() and
> how you propose do_mmap() should be used.
> 
> At the moment, I have to do most of do_mmap for myself when
> implementing CreateFileMapping() with SEC_IMAGE as a parameter since
> I need to change the VMA ops table. But that only applies to where a
> file-backed PE Image (EXE/DLL) is being mapped.

If you want to change the vma ops table you can replace the f_ops
table with your own one. SYSV ipc uses this also to be able to catch
unmaps.

> I'm not sure how shared sections in PE Images are handled on all
> versions of Windows (ie: whether they are actually shared), but I
> image I could adapt your mechanism for that too. I'd probably just
> have to create a SHMEM file and load the backing data into it, and
> then use the SHMEM as the file to attach to the VMA for that section
> (and then it's someone else's problem as far as swapping is
> concerned).

Oh, that's too much Windows for me ;-)

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
