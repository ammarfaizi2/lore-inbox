Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130316AbQJaSMx>; Tue, 31 Oct 2000 13:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQJaSMe>; Tue, 31 Oct 2000 13:12:34 -0500
Received: from gromco.com ([209.10.98.91]:11072 "HELO gromco.com")
	by vger.kernel.org with SMTP id <S130312AbQJaSMW>;
	Tue, 31 Oct 2000 13:12:22 -0500
Message-ID: <39FF0A71.FE05FAEB@gromco.com>
Date: Tue, 31 Oct 2000 13:07:45 -0500
From: Vladislav Malyshkin <mal@gromco.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>, R.E.Wolff@BitWizard.nl,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FEF039.69FAFDB2@gromco.com> <14846.63285.212616.574188@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, the function remove_duplicates can be written using make rules and
functions.
Using functions "foreach" "if" from make and comparison you can easily
build
a function remove_duplicates in make, no shell involved.
so instead of $(sort) your will have $(remove_duplicates)
written entirely in make.
Vladislav

Peter Samuelson wrote:

> [Vladislav Malyshkin <mal@gromco.com>]
> > You can easily remove duplicates in object files without sorting.
> > You can just use a shell written function.
>
> This is true.  That was something I forgot to mention.  I have looked
> at that as well, and it strikes me as even more of a hack than the
> solutions I mentioned: it is yet another external shell process for
> each invocation of Rules.make (ie each directory).  As I said before,
> though, one man's hack is another man's clean design, so whatever.
>
> Your function is rather long; try this one instead (untested):
>
>   remove_duplicates () {
>     str='';
>     for i; do
>       case "$str " in *" $i "*) ;; *) str="$str $i" ;; esac
>     done
>     echo "$str"
>   }
>
> I still think anything outside the makefiles that's needed to organize
> the build process is a hack.  That includes scripts/pathdown.sh (yes, I
> do have a scheme to get rid of it) and 2.2.18 scripts/kwhich (yes, I
> did propose a working alternative).  It doesn't include scripts/mkdep.c
> (which must do a lot of work as efficiently as possible),
> scripts/Configure et al (which are really standalone programs), or
> scripts/split-include.c (which is really a continuation of Configure).
>
> Peter

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
