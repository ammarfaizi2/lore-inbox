Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268809AbTCBFAc>; Sun, 2 Mar 2003 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbTCBFAc>; Sun, 2 Mar 2003 00:00:32 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:9231 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S268809AbTCBFA2>; Sun, 2 Mar 2003 00:00:28 -0500
Date: Sun, 2 Mar 2003 00:10:10 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030302051010.GB22169@phunnypharm.org>
References: <20030226200208.GA392@elf.ucw.cz> <20030302050420.GA22169@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20030302050420.GA22169@phunnypharm.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2003 at 12:04:20AM -0500, Ben Collins wrote:
> On Wed, Feb 26, 2003 at 09:02:12PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > I've created little project for read-only (for now ;-) bitkeeper
> > clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> > just get it fresh from CVS).
> 
> In case it may be of some help, here's a script that is the result of my
> own reverse engineering of the bitkeeper SCCS files. It can output a
> diff, almost exactly the same as BitKeeper's gnupatch output from a
> BitKeeper repo.


Might aswell supply my hacked sccsdiff script aswell.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sccsdiff

#! /bin/sh

# This file is part of CSSC.
# # Generated automatically from sccsdiff.sh.in by configure.

# Usage:
# sccsdiff [-p] -rsid -rsid [diff-options] s.filename
#

# $Id: sccsdiff.sh.in,v 1.9 2001/11/25 16:01:38 james_youngman Exp $
# LOG   $Log: sccsdiff.sh.in,v $
# LOG   Revision 1.9  2001/11/25 16:01:38  james_youngman
# LOG   Corrected a syntax error.
# LOG
# LOG   Revision 1.8  2001/11/25 14:27:54  james_youngman
# LOG   fixed Debian  Bug#120080: sccs sccsdiff doesn't work (sccsdiff assumes /usr/sccs symlink exists)
# LOG
# LOG   Revision 1.7  1998/03/10 00:22:00  james
# LOG   Support for filenames containing spaces.
# LOG
# LOG   Revision 1.6  1998/03/09 23:25:00  james
# LOG   Bug report from Richard Polton: IRIX's pr(1) requires a space between
# LOG   the "-h" and its argument.
# LOG
# LOG   Revision 1.5  1998/02/09 21:00:19  james
# LOG   Patch from Maurice O'Donnell <mod@tfn.com>: pass "-e" to sed before
# LOG   the sed commands.
# LOG
# LOG   Revision 1.4  1998/01/24 14:15:13  james
# LOG   SCCS compatibility fix -- When "get" fails, exit with value 1, not 2.
# LOG
# LOG   Revision 1.3  1997/12/19 20:40:35  james
# LOG   Modified version of sccsdiff arrived from Richard Polton; took the
# LOG   ideas onboard for a rewrite of sccsdiff.
# LOG
# LOG   Revision 1.2  1997/05/04 14:52:02  james
# LOG   Have to enclose the version string in single rather than double
# LOG   quotes, to protect the dollar signs from shell expansion.
# LOG
# LOG   Revision 1.1  1997/05/04 14:49:22  james
# LOG   Initial revision

# Values substituted by configure:-
pr=/usr/bin/pr			   # The location of the   pr(1) command:
diff=/usr/bin/diff # The location of the diff(1) command:

# Find the "get" command.  The last value tested is "get", and 
# that's what we use if we can't find get in any other location.
if test x$get = x
then
    # The CSSC Makefile performs a sed substitution on the next line.
    for get in "/usr/local/libexec/cssc/get" /usr/sccs/get get
    do
	if [ -x "$get" ]
	then
	    break
	fi
    done
fi

version='$Revision: 1.9 $ $State: Exp $'
usage() {
cat <<EOF
$0 [-p] -rsid -rsid [diff-options] s.filename [s.secondfile...]
EOF
}

use_pr=false
first_sid=
second_sid=
diff_options=
sccs_files=

while test $# -gt 0
do
	case $1 in 
	    --help)
		usage
		exit 0
		;;
	    --version)
		echo "$version"
		exit 0
		;;
	    -p) use_pr=true 
		shift
		;;
	    -r*)      
		if test x$first_sid = x
		then
		    first_sid=$1
		else
		    if test x$second_sid = x
		    then
			second_sid=$1
		    else
			exec >&2
			usage
			echo "Too many -r options."
			exit 1
		    fi
		fi
		shift
		;;
	    -*)
		diff_options="${diff_options} $1"
		shift
		;;
	    *)  
		# That is an SCCS file, leave it and everything 
		# following it in $*.
		break
		;;
	esac
done

# Show what we got...
## echo "use_pr=" $use_pr
## echo "first SID=" $first_sid
## echo "second SID=" $second_sid
## echo "diff options=" $diff_options
## echo "SCCS files=" $*
## echo \$\# = $#

if test x$second_sid = x
then
    exec >&2
    echo Two SIDs must be specified with the -r option.
    usage
    exit 1
fi


# Remove the leading "-r" from $first_sid and $second_sid
# so that we can echo the correct string as the header line
# introducing the diff.
first_sid=`echo   $first_sid | sed -e 's/^-r//' `
second_sid=`echo $second_sid | sed -e 's/^-r//' `

getprefix=/tmp/get.$$.
g1="${getprefix}${first_sid}"
g2="${getprefix}${second_sid}"
dfile=${getprefix}d${first_sid}${second_sid}

while test $# -gt 0
do
    rm -f "$g1" "$g2" "$dfile"
    sccsfile="$1"
    shift 

    header="$sccsfile: $first_sid vs. $second_sid"

    if test $first_sid = 1 -o $first_sid = 1.0; then
	touch "${g1}"
    else
	${get:-get} -r$first_sid -s -k "-G${g1}" "${sccsfile}" || {
	    exec >&2
	    echo "Failed to get version $first_sid from $sccsfile"
	    exit 1
	}
    fi
    if test $second_sid = 1 -o $second_sid = 1.0; then
	touch "${g2}"
    else
	${get:-get} -r$second_sid -s -k "-G${g2}" "${sccsfile}" || {
	    rm -f "$g1"
	    exec >&2
	    echo "Failed to get version $second_sid from $sccsfile"
	    exit 1
        }
    fi

    # in case noclobber is set...
    rm -f "$dfile"

    # Ignore return value of diff since it just tells us
    # if the two files are different.
    "$diff" $diff_options "$g1" "$g2" > "$dfile"
    if test -f "$dfile" 
    then				  # Output file exists.
        if test -s "$dfile" 
        then				  # Output file is not empty.
	    if $use_pr
	    then
		$pr -h "$header"        < $dfile  
	    else
		echo $header
		cat "$dfile"
	    fi
        else				  # Output file is empty.
	    echo No differences.
	fi
    else				  # No output file at all!
        echo "$diff produced no output file." >&2
        exit 2
    fi
done					  # Loop over all named SCCS files.
rm -f "$g1" "$g2" "$dfile"
exit 0

# Local Variables:
# Mode: shell
# End:


--dTy3Mrz/UPE2dbVg--
