Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQJaQUt>; Tue, 31 Oct 2000 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQJaQUj>; Tue, 31 Oct 2000 11:20:39 -0500
Received: from gromco.com ([209.10.98.91]:62764 "HELO gromco.com")
	by vger.kernel.org with SMTP id <S129480AbQJaQU3>;
	Tue, 31 Oct 2000 11:20:29 -0500
Message-ID: <39FEF039.69FAFDB2@gromco.com>
Date: Tue, 31 Oct 2000 11:15:53 -0500
From: Vladislav Malyshkin <mal@gromco.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: peter@cadcamlab.org, R.E.Wolff@BitWizard.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,
You can easily remove duplicates in object files without sorting. You
can just use a shell written function.
This is an example of such function (bash written).
It removes the duplicates from the argument and prints the result to
stdout.
No sorting used.

# This function removes duplicates from a string
remove_duplicates() {
 if [ $# -ne 1 ]; then
  echo "usage: remove_duplicates string" 1>&2
  exit 1
 fi
 str=""
 for tmpvar1 in $1 ; do
  flag_found=0
  for tmpvar2 in $str ; do
   if [ "${tmpvar1}" = "${tmpvar2}" ]; then
    flag_found=1
    break
   fi
  done
  if [ "${flag_found}" -eq 0 ]; then
    str="${str} ${tmpvar1}"
  fi
 done
 echo "${str}"
 return 0
}

# This is a usage example.
x="`remove_duplicates \"a b c d e a b c\"`"
echo "$x"

Vladislav

---Peter Samuelson wrote:
>> And it should make all this FIRST/LAST object file mockery a total
>> non-issue, because the whole concept turns out to be completely
>> unnecessary.
>>
>> Is there anything that makes this more complex than what I've
>> outlined above?
>
>One thing. The main benefit of $(sort), which I haven't heard you
>address yet, is to remove duplicate files. Think about 8390.o, and how
>many net drivers require it. There are two ways to handle this:
>
>  obj-$(CONFIG_WD80x3) += wd.o 8390.o
>  obj-$(CONFIG_EL2) += 3c503.o 8390.o
>  obj-$(CONFIG_NE2000) += ne.o 8390.o
>  obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
>  obj-$(CONFIG_HPLAN) += hp.o 8390.o

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
